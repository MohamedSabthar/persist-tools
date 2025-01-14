import ballerina/sql;
import ballerinax/mysql;
import ballerina/time;
import ballerina/persist;
import foo/perist_generate_7 as entities;

public client class MedicalNeed1Client {

    private final string entityName = "MedicalNeed1";
    private final sql:ParameterizedQuery tableName = `MedicalNeeds1`;

    private final map<persist:FieldMetadata> fieldMetadata = {
        needId: {columnName: "needId", 'type: int, autoGenerated: true},
        itemId: {columnName: "itemId", 'type: int},
        beneficiaryId: {columnName: "beneficiaryId", 'type: int},
        period: {columnName: "period", 'type: time:Civil},
        urgency: {columnName: "urgency", 'type: string},
        quantity: {columnName: "quantity", 'type: int}
    };
    private string[] keyFields = ["needId"];

    private persist:SQLClient persistClient;

    public function init() returns error? {
        mysql:Client dbClient = check new (host = host, user = user, password = password, database = database, port = port);
        self.persistClient = check new (dbClient, self.entityName, self.tableName, self.keyFields, self.fieldMetadata);
    }

    remote function create(entities:MedicalNeed1 value) returns entities:MedicalNeed1|error? {
        sql:ExecutionResult result = check self.persistClient.runInsertQuery(value);
        return {needId: <int>result.lastInsertId, itemId: value.itemId, beneficiaryId: value.beneficiaryId, period: value.period, urgency: value.urgency, quantity: value.quantity};
    }

    remote function readByKey(int key) returns entities:MedicalNeed1|error {
        return (check self.persistClient.runReadByKeyQuery(entities:MedicalNeed1, key)).cloneWithType(entities:MedicalNeed1);
    }

    remote function read(map<anydata>? filter = ()) returns stream<entities:MedicalNeed1, error?>|error {
        stream<anydata, error?> result = check self.persistClient.runReadQuery(entities:MedicalNeed1, filter);
        return new stream<entities:MedicalNeed1, error?>(new MedicalNeed1Stream(result));
    }

    remote function update(record {} 'object, map<anydata> filter) returns error? {
        _ = check self.persistClient.runUpdateQuery('object, filter);
    }

    remote function delete(map<anydata> filter) returns error? {
        _ = check self.persistClient.runDeleteQuery(filter);
    }

    function close() returns error? {
        return self.persistClient.close();
    }
}

public class MedicalNeed1Stream {

    private stream<anydata, error?> anydataStream;

    public isolated function init(stream<anydata, error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|entities:MedicalNeed1 value;|}|error? {
        var streamValue = self.anydataStream.next();
        if streamValue is () {
            return streamValue;
        } else if (streamValue is error) {
            return streamValue;
        } else {
            record {|entities:MedicalNeed1 value;|} nextRecord = {value: check streamValue.value.cloneWithType(entities:MedicalNeed1)};
            return nextRecord;
        }
    }

    public isolated function close() returns error? {
        return self.anydataStream.close();
    }
}

