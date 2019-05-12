package com.github.davidmoten.geo;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class Base32Test {

    @Before
    public void setUp() throws Exception {
    }

    @After
    public void tearDown() throws Exception {
    }

    @Test
    public void encodeBase32() throws Exception {
        String encode_single = Base32.encodeBase32(50);
        assertEquals("00000000001k", encode_single);
        String encode_single_2 = Base32.encodeBase32(-50);
        assertEquals("-00000000001k", encode_single_2);

        String encode = Base32.encodeBase32(32, 2);
        assertEquals("10", encode);
        String encode_2 = Base32.encodeBase32(-32, 2);
        assertEquals("-10", encode_2);
    }

    @Test
    public void decodeBase32()   {
//        long ans = Base32.decodeBase32("bcde");
//        assertEquals(339341, ans);

        long gp = Base32.decodeBase32("-1");
        assertEquals(-1, gp);

        long temp = Base32.decodeBase32("");
        assertEquals(0, temp);

        try{
            long ans_2 = Base32.decodeBase32("a");
        }
        catch (Exception e){
            System.out.println(e);
        }
        try{
            long ans_3 = Base32.decodeBase32("-a");
        }
        catch (Exception e){
            System.out.println(e);
        }

    }

    @Test
    public void  padLeftWithZerosToLength() {

        assertEquals("0000Test1", Base32.padLeftWithZerosToLength("Test1",9));
        assertEquals("Test1", Base32.padLeftWithZerosToLength("Test1",-1));
        assertEquals("000000000", Base32.padLeftWithZerosToLength("",9));
    }

    @Test
    public void  getCharIndex() {
        assertEquals(10, Base32.getCharIndex('b'));
        try{
            assertEquals(3, Base32.getCharIndex('a'));
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
    }


}