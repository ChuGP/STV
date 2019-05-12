package com.github.davidmoten.geo.mem;

import com.google.common.base.Optional;
import com.google.common.base.Predicate;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class GeomemTest {
    Info<Double, Double>temp ;
    Geomem<Double,Double> gp ;
    private Optional<Double> id;
    private final double lat=1.0,  lon=2.0,value=4.0;
    private final long time=3;
    @Before
    public void setUp() throws Exception {
        id = Optional.of(689.0);
        temp = new Info<Double, Double>(lat,lon,time,value, id);
        gp = new Geomem<Double,Double>();
        gp.add(temp);
    }

    @Test
    public void find() {
        Geomem<Double,Double> Nolenth = new Geomem<Double,Double>();
        try {
            Iterable<Info<Double, Double>>test = Nolenth.find(5,0,1,5,0,5);
            assertEquals(temp,test.iterator().next());
        }
        catch(Exception e){
          System.out.println(e);
        }
        Iterable<Info<Double, Double>>ans = gp.find(5,0,1,5,0,5);
        assertEquals(temp,ans.iterator().next());
    }

    @Test
    public void createRegionFilter() {
        Predicate<Info<Double, Double>> createRegionFilter_1 = gp.createRegionFilter(0,2,1,2);
        assertFalse(createRegionFilter_1.apply(temp));

        Predicate<Info<Double, Double>> createRegionFilter_2 = gp.createRegionFilter(0,2,0,2);
        assertFalse(createRegionFilter_2.apply(temp));


    }

    @Test
    public void add() {
        Info<Double, Double>  fortest = new Info<Double, Double>(lat,lon,time,value, id);
        gp.add(fortest);
        Iterable<Info<Double, Double>>ans = gp.find(5,0,1,5,0,5);
        assertEquals(fortest,ans.iterator().next());

    }

    @Test
    public void add1() {
        gp.add(lat,lon,time,value);
        Iterable<Info<Double, Double>>ans = gp.find(5,0,1,5,0,5);
        assertEquals(lat,ans.iterator().next().lat(),0.0);
        assertEquals(lon,ans.iterator().next().lon(),0.0);
        assertEquals(time,ans.iterator().next().time(),0.0);
        assertEquals(value,ans.iterator().next().value(),0.0);
    }

    @Test
    public void add2() {
        gp.add(lat,lon,time,value);
        Iterable<Info<Double, Double>>ans = gp.find(5,0,1,5,0,5);
        assertEquals(lat,ans.iterator().next().lat(),0.0);
        assertEquals(lon,ans.iterator().next().lon(),0.0);
        assertEquals(time,ans.iterator().next().time(),0.0);
        assertEquals(value,ans.iterator().next().value(),0.0);
//        assertEquals(id,ans.iterator().next().id());
    }

    @Test
    public void add3() {
        gp.add(lat,lon,time,value,id);
        Iterable<Info<Double, Double>>ans = gp.find(5,0,1,5,0,5);
        assertEquals(lat,ans.iterator().next().lat(),0.0);
        assertEquals(lon,ans.iterator().next().lon(),0.0);
        assertEquals(time,ans.iterator().next().time(),0.0);
        assertEquals(value,ans.iterator().next().value(),0.0);
        assertEquals(id,ans.iterator().next().id());
    }
}