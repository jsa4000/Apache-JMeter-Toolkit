package com.jmeter.helpers;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.File;
import java.io.IOException;

import static org.junit.Assert.assertTrue;

public class DownloadHelperTest {

    @Before
    public void setUp() throws Exception {
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void download2() throws IOException {
        String outputFile = "googlelogo_color_120x44dp.png";
        String url = "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_120x44dp.png";

        DownloadHelper.downloadImage(url,outputFile);

        File f = new File(outputFile);

        assertTrue(f.exists());

        f.delete();
    }



}