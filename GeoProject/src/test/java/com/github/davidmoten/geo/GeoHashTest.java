package com.github.davidmoten.geo;

import com.google.common.collect.Sets;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

public class GeoHashTest {
    GeoHash gp ;
    LatLong temp ;

    String hash = "TESTDATA54965959";
    @Before
    public void setUp() throws Exception {
        temp = new LatLong(5,6);
    }

    @Test
    public void fromLongToString() {

        assertEquals("00",gp.fromLongToString(2));

        try {
            assertEquals("00000",gp.fromLongToString(-1));

        }
        catch(Exception e)
        {
            assertEquals("invalid long geohash -1",e.getMessage());
        }

        try {
            assertEquals("00000",gp.fromLongToString(13));

        }
        catch(Exception e)
        {
            assertEquals("invalid long geohash 13",e.getMessage());
        }

        try {
            assertEquals("00000",gp.fromLongToString(0));

        }
        catch(Exception e)
        {
            assertEquals("invalid long geohash 0",e.getMessage());
        }
    }

    @Test
    public void heightDegrees() {
        assertEquals(4.190951585769653E-8,gp.heightDegrees(13),0.0);
        assertEquals(0.0439453125,gp.heightDegrees(5),0.0);

        try {
            assertEquals(-1, gp.heightDegrees(-1), 0.0);
        }
        catch(Exception e)
        {
            assertEquals("-1",e.getMessage());
        }
    }

    @Test
    public void widthDegrees() {
        assertEquals(1.0477378964424133E-8,gp.widthDegrees(14),0.0);
        assertEquals(11.25,gp.widthDegrees(2),0.0);
        try {
            assertEquals(-1, gp.widthDegrees(-1), 0.0);
        }
        catch(Exception e)
        {
            assertEquals("-1",e.getMessage());
        }
    }

    @Test
    public void neighbours(){
        List<String> temp = new ArrayList<String>();
        String gp[] = {"iamgn", "bpbpb", "gzzzz", "iamfz", "iamgq", "iamfy", "upbpb", "bpbp8"};
        for (String e:gp)
        {
            temp.add(e);
        }

        assertEquals(temp, GeoHash.neighbours("IAMGP"));

        List<String> temp2 = new ArrayList<String>();
        String gp2[] = {"0", "4", "3", "j", "2", "h", "6", "n"};
        for (String e:gp2)
        {
            temp2.add(e);
        }
        assertEquals(temp2, GeoHash.neighbours("1"));

        try{
            assertEquals(temp, GeoHash.neighbours("-a"));
        }
        catch(Exception e) {
            assertEquals("String index out of range: -1",e.getMessage());
        }

        try{
            assertEquals(temp, GeoHash.neighbours("<>#@$"));
        }
        catch(Exception e) {
            assertEquals("String index out of range: -1",e.getMessage());
        }

        try{
            assertEquals(temp, GeoHash.neighbours("-<>#@$"));
        }
        catch(Exception e) {
            assertEquals("String index out of range: -1",e.getMessage());
        }
    }

    @Test
    public void decodeHash() {
        assertEquals("LatLong [lat=89.912109375, lon=179.82421875]",gp.decodeHash("TEST").toString());
        assertEquals("LatLong [lat=-67.5, lon=-112.5]", GeoHash.decodeHash("1").toString());
        assertEquals("LatLong [lat=53.4375, lon=140.625]", GeoHash.decodeHash("-1").toString());
        assertEquals("LatLong [lat=89.296875, lon=179.296875]", GeoHash.decodeHash("@#$").toString());
    }

    @Test
    public void adjacentHash() {

        assertEquals("tekw", gp.adjacentHash("TEST",Direction.BOTTOM,7));
        assertEquals("tekw", gp.adjacentHash("TEST",Direction.TOP,-7));
        assertEquals("TEST", gp.adjacentHash("TEST",Direction.LEFT,0));
        //========================================================================
        assertEquals("tess", gp.adjacentHash("TEST",Direction.BOTTOM));
        try{
            assertEquals("", gp.adjacentHash("",Direction.BOTTOM));
        }
        catch(Exception e){
            System.out.println(e);
        }
        assertEquals("tesw", gp.adjacentHash("TEST",Direction.TOP));
    }

    @Test
    public void encodeHash() {
        assertEquals("s00000000000",gp.encodeHash(0,0));
        assertEquals("w008nb00j8n0",gp.encodeHash(0,91));
        try{
            assertEquals("w008nb00j8n0",gp.encodeHash(181,0));
        }
        catch(Exception e) {
            assertEquals("latitude must be between -90 and 90 inclusive",e.getMessage());
        }

        try{
            assertEquals("w008nb00j8n0",gp.encodeHash(181,91));
        }
        catch(Exception e) {
            assertEquals("latitude must be between -90 and 90 inclusive",e.getMessage());
        }

        //=========================================================================
        assertEquals("s",gp.encodeHash(0,0,1));

        try{
            assertEquals("s00000000000",gp.encodeHash(181,-89,0));
        }
        catch(Exception e) {
            assertEquals("length must be greater than zero",e.getMessage());
        }

        assertEquals("w",gp.encodeHash(0,91,1));
        try{
            assertEquals("s",gp.encodeHash(0,0,-1));
        }
        catch(Exception e) {
            assertEquals("length must be greater than zero",e.getMessage());
        }

        try{
            assertEquals("s",gp.encodeHash(181,91,1));
        }
        catch(Exception e) {
            assertEquals("latitude must be between -90 and 90 inclusive",e.getMessage());
        }

        try{
            assertEquals("w",gp.encodeHash(181,0,0));
        }
        catch(Exception e) {
            assertEquals("length must be greater than zero",e.getMessage());
        }

        try{
            assertEquals("w",gp.encodeHash(181,0,1));
        }
        catch(Exception e) {
            assertEquals("latitude must be between -90 and 90 inclusive",e.getMessage());
        }

        try{
            assertEquals("w",gp.encodeHash(0,91,0));
        }
        catch(Exception e) {
            assertEquals("length must be greater than zero",e.getMessage());
        }
        assertEquals("s0",gp.encodeHash(temp,2));
        assertEquals("s0uk2w1p45s3",gp.encodeHash(temp));
    }

    @Test
    public void hashLengthToCoverBoundingBox(){
        assertEquals(0, GeoHash.hashLengthToCoverBoundingBox(-4, 3, 2, 5));
        assertEquals(2, GeoHash.hashLengthToCoverBoundingBox(4, 3, 2, 5));
        assertEquals(0, GeoHash.hashLengthToCoverBoundingBox(-1, 2, 3, -4));
        assertEquals(2, GeoHash.hashLengthToCoverBoundingBox(1, -2, 3, -4));
        assertEquals(0, GeoHash.hashLengthToCoverBoundingBox(1, 2, -3, -4));
        assertEquals(2, GeoHash.hashLengthToCoverBoundingBox(-1, -2, -3, -4));
        assertEquals(0, GeoHash.hashLengthToCoverBoundingBox(1, -2, 3, 4));
        assertEquals(2, GeoHash.hashLengthToCoverBoundingBox(1, 2, 3, 4));
        assertEquals(0, GeoHash.hashLengthToCoverBoundingBox(-1, -2, 3, 4));
        assertEquals(0, GeoHash.hashLengthToCoverBoundingBox(-1, -2, -3, 4));
    }

    @Test
    public void right() {
        assertEquals("28",gp.right("22"));
        assertEquals("b",gp.right("i"));
        assertEquals("02",gp.right("00"));
        assertEquals("13",gp.right("11"));
    }

    @Test
    public void left() {
        assertEquals("20",gp.left("22"));
        try{
            assertEquals("b",gp.left("i"));
        }
        catch(Exception e) {
            assertEquals("String index out of range: -1",e.getMessage());
        }
        assertEquals("pb",gp.left("00"));
        assertEquals("0c",gp.left("11"));
    }

    @Test
    public void top() {
        assertEquals("23",gp.top("22"));
        try{
            assertEquals("g",gp.top("i"));
        }
        catch(Exception e) {
            assertEquals("String index out of range: -1",e.getMessage());
        }
        assertEquals("01",gp.top("00"));
        assertEquals("14",gp.top("11"));
    }

    @Test
    public void bottom() {
        assertEquals("0r",gp.bottom("22"));
        try{
            assertEquals("g",gp.bottom("i"));
        }
        catch(Exception e) {
            assertEquals("String index out of range: -1",e.getMessage());
        }
        assertEquals("hp",gp.bottom("00"));
        assertEquals("10",gp.bottom("11"));
    }

    //=======================================================================可用ISP設計的








    @Test
    public void encodeHashToLong() {
        assertEquals(0,gp.encodeHashToLong(0,1,0));
    }



    @Test
    public void hashContains() {
        LatLong centre = gp.decodeHash("TEST");
        LatLong temp = gp.decodeHash("0");
        assertTrue("true",gp.hashContains("TEST",centre.getLat(),centre.getLon()));
        assertTrue("true",gp.hashContains("0",temp.getLat()+20,temp.getLon()));
        assertFalse("false",gp.hashContains("TESTVALUE",2,-1));
    }

    @Test
    public void coverBoundingBoxLongs(){


        try {

            assertEquals(1, GeoHash.coverBoundingBoxLongs(4, 3, 2, 5, 1).getCount(),0);
        }
        catch(Exception e){
            System.out.println(e);
        }
    }

    @Test
    public void coverBoundingBox(){
        assertEquals(Sets.newHashSet("s06", "s07", "s0d", "s0e"),GeoHash.coverBoundingBox(4,3,2,5).getHashes());
    }



    @Test
    public void coverBoundingBoxMaxHashes(){
        try {
            assertEquals(2, GeoHash.coverBoundingBoxMaxHashes(4, 3, 2, 5,3).getHashLength());
        }
        catch(Exception e){
            System.out.println(e);
        }
    }






}