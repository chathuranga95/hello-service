import ballerina/http;

type UserResp record {
    User[] users;
};

type User record {
    string name;
    int age;
};

service / on new http:Listener(9090) {
    resource function get users() returns UserResp {
        // return a mock user response
        return {
            users: [
                {name: "John", age: 30},
                {name: "Doe", age: 25}
            ]
        };
    }
}
