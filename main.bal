import ballerina/http;

type VersionDetails record {
    string 'version;
};

configurable VersionDetails? versionDetails = {
    'version: "dv1.0"
};

service / on new http:Listener(9090) {

    resource function get diag() returns VersionDetails {
        return {'version: "v1.0"};
    }

    resource function get configured\-version() returns string {
        if versionDetails is VersionDetails {
            return (<VersionDetails>versionDetails).'version;
        }
        return "Version details not configured";
    }
}
