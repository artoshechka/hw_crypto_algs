`timescale 1ns / 1ns

module tb_implication;
  logic a, b, y;
  logic y_ref;

  initial begin
    $dumpfile("work/wave.ocd");
    $dumpvars(0, tb_implication);
  end

  initial begin
    for (int i = 0; i < 4; i++) begin
      {a, b} = i;  #1;
      y_ref = (!a || b);
      assert (y == y_ref)
      else $error($sformatf("Wrong result for a = %b, b = %b: expected - %b, rtl - %b", a, b, y_ref, y));
    end

    /*
    Equivalent to:
    a = 1'b0; b = 1'b0; #1;
    y_ref = (!a || b);
    assert (y == y_ref)
    else $error($sformatf("Wrong result for a = %b, b = %b: expected - %b, rtl - %b", a, b, y_ref, y));

    a = 1'b0; b = 1'b1; #1;
    y_ref = (!a || b);
    assert (y == y_ref)
    else $error($sformatf("Wrong result for a = %b, b = %b: expected - %b, rtl - %b", a, b, y_ref, y));

    a = 1'b1; b = 1'b0; #1;
    y_ref = (!a || b);
    assert (y == y_ref)
    else $error($sformatf("Wrong result for a = %b, b = %b: expected - %b, rtl - %b", a, b, y_ref, y));

    a = 1'b1; b = 1'b1; #1;
    y_ref = (!a || b);
    assert (y == y_ref)
    else $error($sformatf("Wrong result for a = %b, b = %b: expected - %b, rtl - %b", a, b, y_ref, y));
    */

    $finish;
  end

  implication dut (
    .a(a),
    .b(b),
    .y(y)
  );

endmodule