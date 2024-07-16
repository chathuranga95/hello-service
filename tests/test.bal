import ballerina/http;
import ballerina/test;

http:Client clientEp = check new ("http://localhost:9090");

@test:Config {
    groups: ["diag"]
}
function testGetDiag() returns error? {
    VersionDetails resp = check clientEp->get("/diag");
    test:assertEquals(resp, {"version": "v1.0", "secret": "mySecretValue"}, "Failed to get the diag resource");
}
