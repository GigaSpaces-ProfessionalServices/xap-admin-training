/*
 * Copyright (c) 2008-2016, GigaSpaces Technologies, Inc. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.gigaspaces.test;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.openspaces.core.GigaSpace;

import java.io.IOException;


public class SpaceTestCase {
    private GigaSpace gigaSpace;

    @Before
    public void before() {
        gigaSpace = Program.getOrCreateSpace("demo");
    }

    @Test
    public void testSpaceOperations() throws IOException {

        gigaSpace.clear(new Object());
        System.out.println("Assert space is empty");
        Assert.assertEquals(0, gigaSpace.count(null));
        String[] pl = {"Every","Day we are doing", "homework and tests","And we need a holiday","as soon as possiable"," and we need to go out", " and we want a nice vacation"};
        for (int k=0; k<10000; k++){

//            MyBigObjectNoStorageOpt myBigObjectNoStorageOpt = new MyBigObjectNoStorageOpt(k, ""+k, ""+k);
//            myBigObjectNoStorageOpt.setPayload(pl);
//            myBigObjectNoStorageOpt.setVals("test"+k);
//            gigaSpace.write(myBigObjectNoStorageOpt);

//            MyBigObject152StorageOpt myBigObject152StorageOpt = new MyBigObject152StorageOpt(k, ""+k, ""+k);
//            myBigObject152StorageOpt.setPayload(pl);
//            myBigObject152StorageOpt.setVals("test"+k);
//            gigaSpace.write(myBigObject152StorageOpt);

//            MyBigObject158Direct myBigObject158Direct = new MyBigObject158Direct(k, ""+k, ""+k);
//            myBigObject158Direct.setPayload(pl);
//            myBigObject158Direct.setVals("test"+k);
//            gigaSpace.write(myBigObject158Direct);

            MyBigObject158Sequential myBigObject158Sequential = new MyBigObject158Sequential(k, ""+k, ""+k);
            myBigObject158Sequential.setPayload(pl);
            myBigObject158Sequential.setVals("test"+k);
            gigaSpace.write(myBigObject158Sequential);

        }
    }
}
