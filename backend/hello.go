package main

import (
	"database/sql"
	"fmt"

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

func queryMultiRow() {
	rows, err := db.Query("select * from user")
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

func main() {
	err := initDB()
	if err != nil {
		fmt.Printf("init db failed, err: %v\n", err)
		return
	}
	queryRow()
	queryMultiRow()
	insertRow()
	updateRow()
	deleteRow()
}
