以下用一個簡單的「更換姓名」範例，讓你一眼看出指標（Pointer）與引用（Reference）在語法上的差別：

## 1. 使用指標 Pointer (* 與 &)
這是傳統 C 語言風格，呼叫時必須明確「取址」，函數內必須明確「解引用」。

struct User {
    string name;
};
// 參數用 * 接收地址void changeName(User* u) {
    u->name = "Alice"; // 使用 -> 存取成員
}
int main() {
    User person = {"Bob"};
    // 呼叫時必須加 & 取得地址
    changeName(&person); 
}


## 2. 使用引用 Reference (&)
這是 C++ 特有的語法，看起來像傳入一般變數，但實際上操作的是同一個物件。

struct User {
    string name;
};
// 參數用 & 宣告為引用void changeName(User& u) {
    u.name = "Alice";  // 使用 . 存取成員，像操作一般變數
}
int main() {
    User person = {"Bob"};
    // 呼叫時直接傳入物件，不需加符號
    changeName(person); 
}


## 快速對照表

| 特性 | 指標 Pointer (*) | 引用 Reference (&) |
|---|---|---|
| 定義方式 | User* u | User& u |
| 呼叫方式 | func(&person) (需取址) | func(person) (直接傳) |
| 內部操作 | u->name (需解引用) | u.name (直接用) |
| 空值安全性 | 可以是 nullptr (需檢查) | 不能為空 (較安全) |
| 直觀程度 | 像在操作「地址」 | 像在操作「本體」的別名 |


📍 建議：在 C++ 中，如果不需要處理「空值（NULL）」或「更換指向對象」，優先使用引用 (&)，程式碼會更乾淨且安全。
若你想知道兩者在記憶體底層有什麼不同，或是什麼時候一定要用指標，可以再告訴我！

