// Copyright (c) 2022 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
import ballerina/persist;
import foo/tool_test_generate_15.foo as entities;

@persist:Entity {
    key: ["id"],
    tableName: "Profiles"
}
public type Profile record  {|
    readonly int id;
    string name;
    @persist:Relation {keyColumns: ["userId"], reference: ["id"]}
    entities:User user?;
|};

@persist:Entity {
    key: ["id"],
    tableName: "MultipleAssociations"
}
public type MultipleAssociations record {|
    readonly int id;
    string name;

    @persist:Relation {keyColumns: ["profileId"], reference: ["id"]}
    Profile profile?;

    @persist:Relation {keyColumns: ["userId"], reference: ["id"]}
    entities:User user?;
|};



