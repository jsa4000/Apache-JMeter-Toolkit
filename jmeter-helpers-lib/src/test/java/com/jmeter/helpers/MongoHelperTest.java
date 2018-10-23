package com.jmeter.helpers;

import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

public class MongoHelperTest {

    private String mongoURI = "mongodb://root:root@localhost:27017/test?authSource=admin";

    private String databaseName= "test";
    private String collectionName = "collection_test";

    private MongoClient client;

//    @Before
//    public void setUp() throws Exception {
//        client = MongoHelper.createConnection(mongoURI);
//    }
//
//    @After
//    public void tearDown() throws Exception {
//        if (client != null) client.close();
//    }
//
//    @Test
//    public void getConnection() {
//
//        assertNotNull(client);
//    }
//
//    @Test
//    public void mongodb_getCountCollections_shouldReturnOk() {
//        MongoDatabase db = client.getDatabase(databaseName);
//        MongoCollection collection = db.getCollection(collectionName);
//
//        assertTrue(collection.countDocuments()>0);
//    }
//
//    @Test
//    public void mongodb_setConnection_shouldReturnOk() {
//        String macAddress = "00-00-00-00-00-AA";
//
//        MongoDatabase db = client.getDatabase(databaseName);
//        MongoCollection collection = db.getCollection(collectionName);
//
//        if (!collection.find(Filters.eq("_id", macAddress)).iterator().hasNext())
//        {
//
//            BasicDBObject document = new BasicDBObject();
//            document.put("_id", macAddress);
//            document.put("password", BCryptHelper.hash(macAddress));
//
//            collection.insertOne(new Document(document));
//
//        }
//
//        Object expectedDoc = collection.findOneAndDelete(Filters.eq("_id", macAddress));
//
//        assertNotNull(expectedDoc);
//    }
}