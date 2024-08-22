#!/usr/bin/env bats
load bats-extra

@test 'Orange and orange and black' {
    #[[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'orange orange black'
    assert_success
    assert_output '33 ohms'
}

@test 'Blue and grey and brown' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'blue grey brown'
    assert_success
    assert_output '680 ohms'
}

@test 'Brown and red and red' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'brown red red'
    assert_success
    assert_output '1200 ohms'
}

@test 'Red and black and red' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'red black red'
    assert_success
    assert_output '2 kiloohms'
}

@test 'Green and brown and orange' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'green brown orange'
    assert_success
    assert_output '51 kiloohms'
}

@test 'Yellow and violet and yellow' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'yellow violet yellow'
    assert_success
    assert_output '470 kiloohms'
}

@test 'Blue and violet and grey' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'blue violet blue'
    assert_success
    assert_output '67 megaohms'
}

@test 'Minimum possible value' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'black black black'
    assert_success
    assert_output '0 ohms'
}

@test 'Maximum possible value' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'white white white'
    assert_success
    assert_output '99 gigaohms'
}

@test 'Invalid first color' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'foo white white'
    assert_failure
    assert_output --partial 'invalid color'
}

@test 'Invalid second color' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'white bar white'
    assert_failure
    assert_output --partial 'invalid color'
}

@test 'Invalid third color' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'white white baz'
    assert_failure
    assert_output --partial 'invalid color'
}

@test 'First two colors make an invalid octal number' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'black grey black'
    assert_success
    assert_output '8 ohms'
}

@test 'Ignore extra colors' {
    [[ $BATS_RUN_SKIPPED == "true" ]] || skip
    run sed -E -f resistor-color-trio.sed <<< 'blue green yellow orange'
    assert_success
    assert_output '650 kiloohms'
}
