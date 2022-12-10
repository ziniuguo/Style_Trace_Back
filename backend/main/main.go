package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"math"
	"net/http"
	"strconv"
	"strings"
	"sync"

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
	UserId   int
	History  string
}

type BrandInfo struct {
	Id           int
	Brand        string
	Category     string
	Description  string
	ImgUrl       string
	OnlinePrice  string
	OfflinePrice string
}

type BrandWithRate struct {
	Brand BrandInfo
	Rate  int
}

func queryUserRowByName(searchName any) UserInfo {
	var id int
	var username string
	var pw string
	var userid int
	var history string
	err := db.QueryRow("select id,username,password,userid,history from user where username=?", searchName).Scan(&id, &username, &pw, &userid, &history)
	userInfo := UserInfo{Id: id, Username: username, Password: pw, UserId: userid, History: history}
	if err != nil {
		fmt.Printf("scan failed, err: %v\n", err)
		return userInfo
	}
	fmt.Println("query success!")
	return userInfo
}

func queryUserRowByUsrID(searchName any) UserInfo {
	var id int
	var username string
	var pw string
	var userid int
	var history string
	err := db.QueryRow("select id,username,password,userid,history from user where userid=?", searchName).Scan(&id, &username, &pw, &userid, &history)
	userInfo := UserInfo{Id: id, Username: username, Password: pw, UserId: userid, History: history}
	if err != nil {
		fmt.Printf("scan failed, err: %v\n", err)
		return userInfo
	}
	fmt.Println("query success!")
	// fmt.Printf("id: %d, username: %s, password: %s, userid: %d\n", userInfo.Id, userInfo.Username, userInfo.Password, userInfo.Userid, userInfo.History)
	return userInfo
}

func queryProductRowByName(searchCat any) BrandInfo {
	var id int
	var brand string
	var category string
	var description string
	var imgUrl string
	var onlinePrice string
	var offlinePrice string
	err := db.QueryRow(`select id, brand, category, description, online_price, offline_price, img_path from product_info where category=?`, searchCat).Scan(&id, &brand, &category, &description, &onlinePrice, &offlinePrice, &imgUrl)
	productInfo := BrandInfo{Id: id, Brand: brand, Category: category, Description: description, ImgUrl: imgUrl, OnlinePrice: onlinePrice, OfflinePrice: offlinePrice}
	if err != nil {
		fmt.Printf("scan failed, err: %v\n", err)
		return productInfo
	}
	fmt.Println("query success!")
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

func queryClassById(id int) BrandInfo {
	var brand string
	var category string
	var description string
	var imgUrl string
	var onlinePrice string
	var offlinePrice string
	err := db.QueryRow(`select id, brand, category, description, online_price, offline_price, img_path from product_info where id=?`, id).Scan(&id, &brand, &category, &description, &onlinePrice, &offlinePrice, &imgUrl)
	productInfo := BrandInfo{Id: id, Brand: brand, Category: category, Description: description, ImgUrl: imgUrl, OnlinePrice: onlinePrice, OfflinePrice: offlinePrice}
	if err != nil {
		fmt.Printf("scan failed, err: %v\n", err)
		return productInfo
	}
	fmt.Println("query success!")
	// fmt.Printf("category: %s, description: %s, price: %f\n", category, description, price)
	return productInfo
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

func asyncQueryForBrandInfo(brands *[]BrandWithRate, class string, index int, wg *sync.WaitGroup) {
	fmt.Println(class)
	brand := queryProductRowByName(class)
	brandWithIndex := BrandWithRate{Brand: brand, Rate: index}
	*brands = append(*brands, brandWithIndex)
	wg.Done()
	fmt.Println(index)
}

func uploadFile(w http.ResponseWriter, r *http.Request) {

	fmt.Println("File Upload Endpoint Hit")
	// Parse our multipart form, 10 << 20 specifies a maximum
	// upload of 10 MB files.
	r.ParseMultipartForm(10 << 20)
	file, _, err := r.FormFile("myFile")
	userId := r.FormValue("userId")

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

	go insertImgRow(filename, userId)
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
	// fmt.Fprintf(w, "Successfully Uploaded File\n")

	// predict class, use python file
	class := predict(filename)

	brands := []BrandWithRate{}

	result := []BrandInfo{}

	index := 0

	var wg sync.WaitGroup
	// retrieve class information from database
	for _, c := range class {
		index++
		wg.Add(1)
		go asyncQueryForBrandInfo(&brands, c, index, &wg)
	}

	wg.Wait()

	cur := 1
	for _ = range brands {
		for _, r := range brands {
			rate := r.Rate
			if rate == cur {
				result = append(result, r.Brand)
				cur++
			}
		}
	}

	brandJson, err := json.Marshal(result)
	// return img and class name
	w.Write(brandJson)
	if err != nil {
		fmt.Println(err)
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

func usrHistory(w http.ResponseWriter, r *http.Request) {

	first := r.URL.Query().Get("first")
	first_int := 0
	last := r.URL.Query().Get("last")
	if first != "" {
		first_int, _ = strconv.Atoi(first)
	}

	var result []BrandInfo
	userid := r.URL.Query().Get("userid")
	intUserid, err := strconv.Atoi(userid)
	if err != nil {
		fmt.Println(err)
	}
	person := queryUserRowByUsrID(intUserid)

	string_slice := strings.Split(person.History, ",")

	last_int := len(string_slice)
	first_int = int(math.Min(float64(first_int), float64(len(string_slice))))

	if last != "" {
		last_int, _ = strconv.Atoi(last)
		last_int = int(math.Min(float64(last_int), float64(len(string_slice))))
	}

	for i := first_int; i < last_int; i++ {
		x, err := strconv.Atoi(string_slice[i])
		productinfo := queryClassById(x)
		if err != nil {
			fmt.Println(err)
		}
		result = append(result, productinfo)
	}
	jsonResp, err := json.Marshal(result)
	if err != nil {
		log.Fatalf("Error happened in JSON marshal. Err: %s", err)
	}
	w.Write(jsonResp)
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

	fs := http.FileServer(http.Dir("./classImg"))
	http.Handle("/", fs)
	http.HandleFunc("/getuser", searchUserByName)
	http.HandleFunc("/getproduct", searchProductByName)
	http.HandleFunc("/insertuser", insertUser)
	http.HandleFunc("/insertproduct", insertProduct)
	http.HandleFunc("/postimg", uploadFile)
	http.HandleFunc("/getimg", getFile)
	http.HandleFunc("/usrhistory", usrHistory)
	log.Fatal(http.ListenAndServe(":8000", nil))
}
