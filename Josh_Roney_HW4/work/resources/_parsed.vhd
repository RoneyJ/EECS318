PACKAGE resources IS

    -- user defined enumerated type
    TYPE level IS ('X', '0', '1', 'Z');
    -- type for vectors (buses)
    TYPE level_vector IS ARRAY (NATURAL RANGE <>) OF level;
    -- subtype used for delays
    SUBTYPE delay IS time;

END resources;
