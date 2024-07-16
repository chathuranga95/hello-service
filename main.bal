import ballerina/http;

configurable string mySecret = ?;

type VersionDetails record {
    string 'version;
    string secret;
};

service / on new http:Listener(9090) {

    resource function get diag() returns VersionDetails {
        return {'version: "v1.0", secret: mySecret};
    }
}
