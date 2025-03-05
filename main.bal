import ballerina/http;
import ballerina/random;

type RandomIntResp record {|
    int randomInt;
|};

service / on new http:Listener(9090) {
    resource function get random\-int() returns RandomIntResp|error {
        int randomInt = check random:createIntInRange(1, 100);
        RandomIntResp randomIntResp = {randomInt};
        return randomIntResp;
    }
}
