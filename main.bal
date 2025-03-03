import ballerina/http;

type ExpenseResp record {
    Expense[] expenses;
    float total;
};

type Expense record {
    string title;
    float amount;
};

service / on new http:Listener(9091) {
    resource function get expenses() returns ExpenseResp {
        // return a mock expense response
        return {
            expenses: [
                {title: "Travel", amount: 100.0},
                {title: "Food", amount: 50.0},
                {title: "Accommodation", amount: 150.0}
            ],
            total: 300.0
        };
    }
}
