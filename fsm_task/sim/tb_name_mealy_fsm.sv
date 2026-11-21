`timescale 1ns / 1ns

module tb_name_mealy_fsm;
  parameter TRANSITIONS = 29;

  logic       rst_ = 1'b0;
  logic       clk_ = 1'b0;
  logic [7:0] data_;
  logic       detected_;
  logic [11:0] testVectors_ [0:TRANSITIONS - 1];
  logic [2:0] expectedState_;
  logic       expectedDetected_;

  initial begin
    $dumpfile("work/wave.ocd");
    $dumpvars(0, tb_name_mealy_fsm);
  end

  always #5 clk_ = ~clk_;

  name_mealy_fsm dut (
      .rst_(rst_),
      .clk_(clk_),
      .data_(data_),
      .detected_(detected_)
  );

  initial begin
    $readmemb("sequence.tv", testVectors_);

    @(posedge clk_);
    rst_ = 1'b1;
    @(posedge clk_);
    rst_ = 1'b0;

    for (int i = 0; i < TRANSITIONS; i++) begin
      {data_, expectedDetected_, expectedState_} = testVectors_[i];
      @(posedge clk_);

      assert (detected_ == expectedDetected_)
        else $error(
            "Wrong output %0d: data = %c, expected = %b, actual = %b",
            i,
            data_,
            expectedDetected_,
            detected_
        );

      #1;
      assert (dut.currentState == expectedState_)
        else $error(
            "Wrong state %0d: data = %c, expected = %0d, actual = %0d",
            i,
            data_,
            expectedState_,
            dut.currentState
        );
    end

    @(posedge clk_);
    $finish;
  end
endmodule
