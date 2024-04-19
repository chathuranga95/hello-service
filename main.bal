import ballerina/http;

type VersionDetails record {
    string 'version;
};

final string 'version = "v2.1";

service / on new http:Listener(9090) {
    resource function get diag() returns VersionDetails {
        return {"endpoint": "diagnostics", "version": 'version};
    }
}
