import ballerina/http;

configurable string versionValue = ?;

type VersionDetails record {
    string 'version;
};

service / on new http:Listener(9090) {

    resource function get diag() returns VersionDetails {
        return {'version: versionValue};
    }
}
