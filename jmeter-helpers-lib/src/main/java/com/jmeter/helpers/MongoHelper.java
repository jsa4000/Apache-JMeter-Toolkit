package com.jmeter.helpers;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;

public class MongoHelper
{
    public static MongoClient createConnection(String url)
    {
        return MongoClients.create(url);
    }
}
