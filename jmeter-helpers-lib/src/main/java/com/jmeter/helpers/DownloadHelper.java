package com.jmeter.helpers;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;

public class DownloadHelper
{

    public static void downloadImage(String url, String outputFile, String token) throws IOException
    {
        URL server = new URL(url);
        URLConnection connection = server.openConnection();

        if (token != null) {
            String basicAuth = "Bearer " + token;
            connection.setRequestProperty ("Authorization", basicAuth);
        }

        connection.setReadTimeout(60 * 1000);
        connection.setConnectTimeout(60 * 1000);
        connection.connect();

        InputStream initialStream = connection.getInputStream();
        File targetFile = new File(outputFile);
        OutputStream outStream = new FileOutputStream(targetFile);

        int x;
        while ((x = initialStream.read()) != -1) {
            outStream.write(x);
        }
        outStream.close();
    }

    public static void downloadImage(String url, String outputFile) throws IOException
    {
        downloadImage(url, outputFile, null);
    }

}