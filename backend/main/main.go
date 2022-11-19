package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
	"strings"

	_ "github.com/go-sql-driver/mysql"
)

func enableCors(w *http.ResponseWriter) {
	(*w).Header().Set("Access-Control-Allow-Origin", "*")
}

var db *sql.DB = new(sql.DB)

func initDB() (err error) {
	db, err = sql.Open("mysql", "test:123456@tcp(82.156.125.15)/test")
	if err != nil {
		return err
	}
	err = db.Ping()
	if err != nil {
		return err
	}
	return nil
}

type ImgInfo struct {
	Filename string
	UserId   int
}

type UserInfo struct {
	Id       int
	Username string
	Password string
	Userid   int
}

type ProductInfo struct {
	Category    string
	Description string
	Price       float64
}

type BrandInfo struct {
	Name         string
	Description  string
	ImgUrl       any
	OnlinePrice  any
	OfflinePrice any
}

func queryUserRowByName(searchName any) UserInfo {
	var id int
	var username string
	var pw string
	var userid int
	err := db.QueryRow("select id,username,password,userid from user where username=?", searchName).Scan(&id, &username, &pw, &userid)
	userInfo := UserInfo{Id: id, Username: username, Password: pw, Userid: userid}
	if err != nil {
		fmt.Printf("scan failed, err: %v\n", err)
		return userInfo
	}
	fmt.Println("query success!")
	// fmt.Printf("id: %d, username: %s, password: %s, userid: %d\n", userInfo.Id, userInfo.Username, userInfo.Password, userInfo.Userid)
	return userInfo
}

func queryProductRowByName(searchCat any) ProductInfo {
	var description string
	var category string
	var price float64
	err := db.QueryRow("select category, description, price from product_info where category=?", searchCat).Scan(&category, &description, &price)
	productInfo := ProductInfo{Category: category, Description: description, Price: price}
	if err != nil {
		fmt.Printf("scan failed, err: %v\n", err)
		return productInfo
	}
	fmt.Println("query success!")
	// fmt.Printf("category: %s, description: %s, price: %f\n", category, description, price)
	return productInfo
}

func queryImgRowByUserId(userId int) []string {
	var filename string
	var files []string
	rows, err := db.Query("select filename from img_res where userid=?", userId)
	if err != nil {
		log.Fatal(err)
	}

	defer rows.Close()

	for rows.Next() {
		if err := rows.Scan(&filename); err != nil {
			panic(err)
		}
		files = append(files, filename)
	}

	fmt.Println("query success!")
	return files
}

func queryClassByRow(brandName string) BrandInfo {
	var name string
	var description string
	var imgUrl any
	var onlinePrice any
	var offlinePrice any
	err := db.QueryRow(`select category, description, online_price, offline_price, img_path from product_info where category=?`, brandName).Scan(&name, &description, &onlinePrice, &offlinePrice, &imgUrl)
	brand := BrandInfo{Name: name, Description: description, ImgUrl: imgUrl, OnlinePrice: onlinePrice, OfflinePrice: offlinePrice}
	if err != nil {
		fmt.Printf("scan failed, err: %v\n", err)
		return brand
	}
	fmt.Println("query success!")
	// fmt.Printf("category: %s, description: %s, price: %f\n", category, description, price)
	return brand
}

func insertUserRow(id int, username string, password string, userid int) {
	ret, err := db.Exec("insert into user(id, username, password, userid) values (?,?,?,?)", id, username, password, userid)
	if err != nil {
		fmt.Printf("insert failed, err:%v\n", err)
		return
	}
	_, err = ret.LastInsertId()
	if err != nil {
		fmt.Printf("get lastinsert ID failed, err:%v\n", err)
		return
	}
	fmt.Printf("insert success, the id is %d\n", id)
}

func insertProductRow(category string, description string, price float64) {
	ret, err := db.Exec("insert into product_info(category, description, price) values (?,?,?)", category, description, price)
	if err != nil {
		fmt.Printf("insert failed, err:%v\n", err)
		return
	}
	_, err = ret.LastInsertId()
	if err != nil {
		fmt.Printf("get lastinsert ID failed, err:%v\n", err)
		return
	}
	fmt.Printf("insert success, the category is %s\n", category)
}

func insertImgRow(filename string, userid string) {
	ret, err := db.Exec("insert into img_res(filename, userid) values (?,?)", filename, userid)
	if err != nil {
		fmt.Printf("insert failed, err:%v\n", err)
		return
	}
	_, err = ret.LastInsertId()
	if err != nil {
		fmt.Printf("get lastinsert ID failed, err:%v\n", err)
		return
	}
	fmt.Printf("insert success, the filename is %s\n", filename)
}

func updateRow() {
	ret, err := db.Exec("update user set name = ? where id = ?", "Tom", 1)
	if err != nil {
		fmt.Printf("update failed, errr:%v\n", err)
		return
	}
	n, err := ret.RowsAffected()
	if err != nil {
		fmt.Printf("get RowsAffected failed, err:%v\n", err)
		return
	}
	fmt.Printf("update success, affected rows: %d\n", n)
}

func deleteRow() {
	ret, err := db.Exec("delete from user where id = ?", 2)
	if err != nil {
		fmt.Printf("delete failed, err:%v\n", err)
		return
	}
	n, err := ret.RowsAffected()
	if err != nil {
		fmt.Printf("get RowsAffected failed, err:%v\n", err)
		return
	}
	fmt.Printf("delete success, affected rows:%d\n", n)
}

func uploadFile(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Header().Set("Content-Type", "application/json")

	fmt.Println("File Upload Endpoint Hit")
	// Parse our multipart form, 10 << 20 specifies a maximum
	// upload of 10 MB files.
	r.ParseMultipartForm(10 << 20)
	file, _, err := r.FormFile("myFile")
	userId := r.FormValue("userid")

	if err != nil {
		fmt.Println("Error Retrieving the File")
		fmt.Println(err)
		return
	}

	defer file.Close()

	// Create a temporary file within our temp-images directory that follows
	// a particular naming pattern
	tempFile, err := ioutil.TempFile("data", "upload-*.png")
	filename := strings.Split(tempFile.Name(), "/")[1]

	insertImgRow(filename, userId)
	if err != nil {
		fmt.Println(err)
	}
	defer tempFile.Close()

	// read all of the contents of our uploaded file into a
	// byte array
	fileBytes, err := ioutil.ReadAll(file)
	if err != nil {
		fmt.Println(err)
	}
	// write this byte array to our temporary file
	tempFile.Write(fileBytes)
	// return that we have successfully uploaded our file!
	fmt.Fprintf(w, "Successfully Uploaded File\n")

	// predict class, use python file
	class := predict(filename)
	fmt.Println(class)

	// retrieve class information from database
	for _, c := range class {
		fmt.Println(c)
		brand := queryClassByRow(c)
		brandJson, err := json.Marshal(brand)
		if err != nil {
			log.Fatalf("Error happened in JSON marshal. Err: %s", err)
		}
		// return img and class name
		w.Write(brandJson)
	}
}

func getFile(w http.ResponseWriter, r *http.Request) {
	userid := r.FormValue("userid")
	intUserid, err := strconv.Atoi(userid)
	if err != nil {
		fmt.Println(err)
	}
	files := queryImgRowByUserId(intUserid)
	for i := 0; i < len(files); i++ {
		fmt.Println(files[i])
	}
}

func searchUserByName(w http.ResponseWriter, r *http.Request) {
	fmt.Println("searching user!")
	enableCors(&w)
	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/json")

	// r.ParseForm()
	name := r.FormValue("username")
	fmt.Println(name)
	person := queryUserRowByName(name)
	jsonResp, err := json.Marshal(person)
	if err != nil {
		log.Fatalf("Error happened in JSON marshal. Err: %s", err)
	}
	var a = make(map[string]any)
	json.Unmarshal(jsonResp, &a)
	fmt.Println(a)
	w.Write(jsonResp)
}

func searchProductByName(w http.ResponseWriter, r *http.Request) {
	fmt.Println("searching user!")
	enableCors(&w)
	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/json")

	r.ParseForm()
	category := r.FormValue("category")
	fmt.Println(category)
	productInfo := queryProductRowByName(category)
	jsonResp, err := json.Marshal(productInfo)
	if err != nil {
		log.Fatalf("Error happened in JSON marshal. Err: %s", err)
	}
	var a = make(map[string]any)
	json.Unmarshal(jsonResp, &a)
	fmt.Println(a)
	w.Write(jsonResp)
}

func insertUser(w http.ResponseWriter, r *http.Request) {
	fmt.Println("inserting user!")
	enableCors(&w)
	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/json")
	// r.ParseForm()
	username := r.FormValue("username")
	userid := r.FormValue("userid")
	pw := r.FormValue("password")
	id := r.FormValue("id")
	intId, _ := strconv.Atoi(id)
	intUserid, _ := strconv.Atoi(userid)
	insertUserRow(intId, username, pw, intUserid)
}

func insertProduct(w http.ResponseWriter, r *http.Request) {
	fmt.Println("inserting product!")
	enableCors(&w)
	w.WriteHeader(http.StatusCreated)
	w.Header().Set("Content-Type", "application/json")
	// r.ParseForm()
	category := r.FormValue("category")
	description := r.FormValue("description")
	price := r.FormValue("price")
	intPrice, _ := strconv.ParseFloat(price, 64)
	insertProductRow(category, description, intPrice)
}

func main() {
	err := initDB()
	if err != nil {
		fmt.Printf("init db failed, err: %v\n", err)
		return
	}
	// queryRowByName("Tom")
	// queryMultiRow()
	// insertRow()
	// updateRow()
	// deleteRow()
	fs := http.FileServer(http.Dir("./classImg"))
	http.Handle("/", fs)
	http.HandleFunc("/getuser", searchUserByName)
	http.HandleFunc("/getproduct", searchProductByName)
	http.HandleFunc("/insertuser", insertUser)
	http.HandleFunc("/insertproduct", insertProduct)
	http.HandleFunc("/postimg", uploadFile)
	http.HandleFunc("/getimg", getFile)
	log.Fatal(http.ListenAndServe(":8000", nil))
}
