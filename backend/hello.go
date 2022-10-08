package main

import (
	"database/sql"
	"fmt"
	"html"
	"io/ioutil"
	"log"
	"net/http"

	_ "github.com/go-sql-driver/mysql"
)

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

type User struct {
	Id    int
	Name  string
	Phone string
}

type Img struct {
	Id int
}

var u *User = new(User)

func queryRow() {
	// 该查询语句等价于select id,name,phone from user where id = 1;
	err := db.QueryRow("select id,name,phone from user where id=?", 1).Scan(&u.Id, &u.Name, &u.Phone)
	if err != nil {
		fmt.Printf("scan failed, err: %v\n", err)
		return
	}
	fmt.Println("query success!")
	fmt.Printf("id: %d, name: %s, phone: %s\n", u.Id, u.Name, u.Phone)
}

func queryMultiRow(name string) {
	rows, err := db.Query("select * from user where name = ?", name)
	if err != nil {
		fmt.Println("query failed, err:%v\n", err)
		return
	}
	defer rows.Close()
	fmt.Println("query success!")
	for rows.Next() {
		err := rows.Scan(&u.Id, &u.Name, &u.Phone)
		if err != nil {
			fmt.Printf("scan failed, err:%v\n", err)
			return
		}
		fmt.Printf("id: %d, name: %s, phone: %s\n", u.Id, u.Name, u.Phone)
	}
}

func insertRow() {
	ret, err := db.Exec("insert into user(name, phone) values (?,?)", "zhaoliu", "123456")
	if err != nil {
		fmt.Printf("insert failed, err:%v\n", err)
		return
	}
	id, err := ret.LastInsertId()
	if err != nil {
		fmt.Printf("get lastinsert ID failed, err:%v\n", err)
		return
	}
	fmt.Printf("insert success, the id is %d\n", id)
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
	fmt.Println("File Upload Endpoint Hit")

	// Parse our multipart form, 10 << 20 specifies a maximum
	// upload of 10 MB files.
	r.ParseMultipartForm(10 << 20)
	// FormFile returns the first file for the given key `myFile`
	// it also returns the FileHeader so we can get the Filename,
	// the Header and the size of the file
	file, handler, err := r.FormFile("myFile")
	if err != nil {
		fmt.Println("Error Retrieving the File")
		fmt.Println(err)
		return
	}
	defer file.Close()
	fmt.Printf("Uploaded File: %+v\n", handler.Filename)
	fmt.Printf("File Size: %+v\n", handler.Size)
	fmt.Printf("MIME Header: %+v\n", handler.Header)

	// Create a temporary file within our temp-images directory that follows
	// a particular naming pattern
	tempFile, err := ioutil.TempFile("data", "upload-*.png")
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
}

func main() {
	err := initDB()
	if err != nil {
		fmt.Printf("init db failed, err: %v\n", err)
		return
	}
	// queryRow()
	// queryMultiRow()
	// insertRow()
	// updateRow()
	// deleteRow()

	http.HandleFunc("/get/name", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello, %q", html.EscapeString(r.URL.Path))
	})

	http.HandleFunc("/postimg", uploadFile)

	log.Fatal(http.ListenAndServe(":4000", nil))
}
