package com.github.davidmoten.geo;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class LatLongTest {
    LatLong gp ;
    @Before
    public void setUp() throws Exception {
       gp = new LatLong(5,6);
    }

    @Test
    public void add() {
        LatLong temp = gp.add(8,7);
        assertEquals(13.0, temp.getLat(),0.1);
    }


}