/*
 *  Copyright (c) 2022, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 *  WSO2 Inc. licenses this file to you under the Apache License,
 *  Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 */

package io.ballerina.persist.tools;

import jdk.jfr.Description;
import org.testng.annotations.Test;

import static io.ballerina.persist.tools.ToolingTestUtils.Command.DBPUSH;
import static io.ballerina.persist.tools.ToolingTestUtils.assertGeneratedDbSources;
import static io.ballerina.persist.tools.ToolingTestUtils.assertGeneratedSourcesNegative;

/**
 * persist tool generate command tests.
 */
public class ToolingDbTest {

    @Test(enabled = true)
    @Description("Database doesn't exist and created in command runtime")
    public void testDbPushA_WithoutDatabase() {
        assertGeneratedDbSources("tool_test_db_push_1", DBPUSH);
    }

    @Test(enabled = true)
    @Description("Command is run outside a ballerina project")
    public void testDbPushB_OutsideBallerinaProject() {
        assertGeneratedSourcesNegative("tool_test_db_push_2", DBPUSH, null);
    }

    @Test(enabled = true, dependsOnMethods = { "testDbPushA_WithoutDatabase" })
    @Description("Database and tables are already available")
    public void testDbPushC_WithExistingTables() {
        assertGeneratedDbSources("tool_test_db_push_3", DBPUSH);
    }

    @Test(enabled = true)
    @Description("Config file is not available")
    public void testDbPushD_WithoutConfigFile() {
        assertGeneratedSourcesNegative("tool_test_db_push_4", DBPUSH, null);
    }
}
