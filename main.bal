import ballerina/http;

type VersionDetails record {
    string 'version;
};

service / on new http:Listener(9090) {

    resource function get diag() returns VersionDetails {
        return {'version: "v1.0"};
    }
}


service / on new http:Listener(9091) {

    resource function get healthz() returns string {
        return "ok";
    }
}