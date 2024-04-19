import ballerina/http;

type VersionDetails record {
    string 'version;
};

final string 'version = "v2.0";

service / on new http:Listener(9090) {
    resource function get diag() returns VersionDetails {
        return {"endpoint": "diagnostics", "version": 'version};
    }
}

service / on new http:Listener(9092) {
    resource function get health() returns VersionDetails {
        return {"endpoint": "health", "version": 'version};
    }
}
