import ballerina.net.http;
import ballerina.lang.xmls;
import ballerina.lang.messages;

import ballerina.lang.system;
import ballerina.lang.jsons;

@http:configuration {basePath:"/version"}
service<http> MavenVersion {

    @http:GET{}
    @http:Path {value:"/getData"}
    resource sayHello (message m) {

        http:ClientConnector mavenVersion = create http:ClientConnector("https://repository.sonatype.org");

        message response = {};

        //messages:setHeader(req, "Content-Type", "application/json");
        response = mavenVersion.get("/service/local/artifact/maven/resolve?r=central-proxy&g=com.h2database&a=h2&v=RELEASE", m);

        var XResponse= messages:getXmlPayload(response);
        xmls:Options options1 = {};
        json JSONResponse = xmls:toJSON(XResponse,options1);

        json myJson = jsons:getJson(JSONResponse,"artifact-resolution");
        //json myJson = jsons:getJson(JSONResponse,"$.artifact-resolution.data.version");
        json myJson2 = myJson.data.version;
        system:println(myJson2);

        //string[] keys = jsons:getKeys(JSONResponse);
        //system:println(keys[0]);
        //messages:setJsonPayload(response,JSONResponse);
        messages:setJsonPayload(response,myJson2);

        reply response;

    }
}
