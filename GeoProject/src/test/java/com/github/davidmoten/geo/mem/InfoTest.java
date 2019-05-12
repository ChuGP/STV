package com.github.davidmoten.geo.mem;

import com.google.common.base.Optional;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class InfoTest {
    Info<Double, Double>gp ;
    private Optional<Double> id;
    private final double lat=1.0,  lon=2.0,value=4.0;
    private final long time=3;
    @Before
    public void setUp() throws Exception {
        id = Optional.of(689.0);
        gp = new Info<Double, Double>(lat,lon,time,value, id);
    }


    @Test
    public void id() {
        assertEquals(Optional.of(689.0),gp.id());
    }

    @Test
    public void lat() {
        assertEquals(lat,gp.lat(),0.0);
    }

    @Test
    public void lon() {
        assertEquals(lon,gp.lon(),0.0);
    }

    @Test
    public void time() {
        assertEquals(time,gp.time(),0.0);
    }

    @Test
    public void value() {
        assertEquals(value,gp.value(),0.0);
    }

    @Test
    public void toStringTest() {
        assertEquals("Info [lat=1.0, lon=2.0, time=3, value=4.0, id=Optional.of(689.0)]",gp.toString());
    }
}