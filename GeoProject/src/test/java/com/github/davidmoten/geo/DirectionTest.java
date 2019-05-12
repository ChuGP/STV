package com.github.davidmoten.geo;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class DirectionTest {

    @Test
    public void opposite() {
        assertEquals(Direction.TOP,Direction.BOTTOM.opposite());
        assertEquals(Direction.BOTTOM,Direction.TOP.opposite());
        assertEquals(Direction.RIGHT,Direction.LEFT.opposite());
        assertEquals(Direction.LEFT,Direction.RIGHT.opposite());
    }
}