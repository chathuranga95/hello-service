import ballerina/http;

type SuccessResponseOk record {|
    *http:Ok;
    SuccessResponseBody body;
|};

type SuccessResponseBody SuccessResponse|FailedResponse;

type SuccessResponse record {
    SUCCESS actionStatus;
    Operations[] operations;
};

type FailedResponse record {
    FAILED actionStatus;
    string failureReason?;
    string failureDEscription?;
};

type User record {
    string id?;
};

type Organization record {
    string id?;
    string name?;
};

type ErrorResponseInternalServerError record {|
    *http:InternalServerError;
    ErrorResponse body;
|};

type addOperation AllowedOperation;

type Request record {
    string grantType?;
    string clientId?;
    string[] scopes?;
    RequestHeaders[] additionalHeaders?;
    RequestParams[] additionalParams?;
};

type RequestParams record {
    string name?;
    string[] value?;
};

type AccessTokenClaims record {
    string name?;
    string|int|boolean|string[] value?;
};

type replaceOperation AllowedOperation;

type ErrorResponse record {
    ERROR actionStatus?;
    string errorMessage?;
    string errorDescription?;
};

type ErrorResponseBadRequest record {|
    *http:BadRequest;
    ErrorResponse body;
|};

type Tenant record {
    string id?;
    string name?;
};

type UserStore record {
    string id?;
    string name?;
};

type removeOperation AllowedOperation;

type AccessToken record {
    AccessTokenClaims[] claims?;
    string[] scopes?;
};

type AllowedOperations (addOperation|replaceOperation|removeOperation)[];

type Event record {
    Request request?;
    Tenant tenant?;
    User user?;
    Organization organization?;
    UserStore userStore?;
    AccessToken accessToken?;
};

type AllowedOperation record {
    "add"|"replace"|"remove" op?;
    string[] paths?;
};

type RequestHeaders record {
    string name?;
    string[] value?;
};

type Operations record {
    string op;
    string path;
    OperationValue value;
};

type OperationValue record {
    string name;
    string value;
};

type RequestBody record {
    string requestId?;
    PRE_ISSUE_ACCESS_TOKEN actionType?;
    Event event?;
    AllowedOperations allowedOperations?;
};

type GrantType TwoFaOtpGrant|SoftTokenOtpGrant|AlwaysTwoFaOtpGrant;

type TwoFaOtpGrant record {
    string twoFa;
    string userId;
    string deviceId;
    string twoFaType;
    string phoneNumber;
    string countryCode;
};

type SoftTokenOtpGrant record {
    string userId;
    string tokenSerialNo;
    string tokenResponse;
};

type AlwaysTwoFaOtpGrant record {
    string twoFa;
    string userId;
    string deviceId;
    string twoFaType;
    string tokenSerialNo;
    string tokenResponse;
    string apiVersion;
    string phoneNumber;
    string countryCode;
};

enum AuthParamNames {
    TWO_FA = "twoFa",
    USER_ID = "userId",
    DEVICE_ID = "deviceId",
    TWO_FA_TYPE = "twoFaType",
    TOKEN_SERIAL_NUMBER = "tokenSerialNo",
    TOKEN_RESPONSE = "tokenResponse",
    API_VERSION = "apiVersion",
    PHONE_NUMBER = "phoneNumber",
    COUNTRY_CODE = "countryCode"
};

enum OtpTypes {
    TWO_FA_OTP = "twoFaOtp",
    SOFT_TOKEN_OTP = "softTokenOtp",
    ALWAYS_TWO_FA_OTP = "alwaysTwoFaOtp"
};

enum ActionTypes {
    PRE_ISSUE_ACCESS_TOKEN
};

enum ActionStatus {
    SUCCESS,
    FAILED,
    ERROR
};

type TwilioStatus record {
    string message?;
    boolean success = false;
    string status = "";
};

type DuoStatus record {
    string result;
    string status;
    string txn_Id?;
    string status_msg?;
};

type DuoServiceConfig record {|
    string url;
    string certPath;
    string username;
    string password;
    string apiKey;
|};

type EntrustConfig record {|
    string certPath;
    string entrustApiApplicationId?;
    string entrustApplicationId;
    string entrustSecret;
    string entrustCloudBaseUrl;
    string tokenSet?;
    string tokenVendorId?;
|};

type EntrustAuthResponse record {
    string authToken = "";
    string expirationTime = "";
    string creationTime = "";
};

const DUO = "duo";
const SMS = "sms";
const CALL = "call";
