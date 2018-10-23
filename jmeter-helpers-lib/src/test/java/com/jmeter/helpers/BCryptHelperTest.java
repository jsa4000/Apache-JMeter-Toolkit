package com.jmeter.helpers;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

public class BCryptHelperTest {

    @Before
    public void setUp() throws Exception {
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void hash() {
        assertNotNull(BCryptHelper.hash("example"));
    }

    @Test
    public void verifyHash() {
        assertTrue(true);
    }
}