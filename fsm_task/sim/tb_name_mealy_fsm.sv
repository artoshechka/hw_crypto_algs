`timescale 1ns / 1ns

module tb_name_mealy_fsm;
  parameter TRANSITIONS = 29;

  logic       clk_ = 1'b0;
  logic       rst_ = 1'b0;
  logic [7:0] data_;
  logic       detected_;
  logic [2:0] stateDbg_;
  logic [12:0] testVectors_ [0:TRANSITIONS - 1];
  logic [2:0] expectedState_;
  logic expectedDetected_;
  logic [255:0] testFile_;
  integer transitionCount_;

  name_mealy_fsm dut (
      .clk_(clk_),
      .rst_(rst_),
      .data_(data_),
      .detected_(detected_),
      .stateDbg_(stateDbg_)
  );

  always #5 clk_ = ~clk_;

  initial begin
    $dumpfile("work/wave.ocd");
    $dumpvars(0, tb_name_mealy_fsm);

    if (!$value$plusargs("TEST=%s", testFile_)) begin
      testFile_ = "sequence_full_path.tv";
    end
    transitionCount_ = TRANSITIONS;
    if (testFile_ == "sequence_correct.tv") transitionCount_ = 6;
    if (testFile_ == "sequence_incorrect.tv") transitionCount_ = 13;
    runTests(testFile_);

    $display("FSM test passed: %s", testFile_);
    $finish;
  end

  task runTests;
    input [255:0] fileName;
    begin
      $readmemb(fileName, testVectors_, 0, transitionCount_ - 1);
      for (int i = 0; i < transitionCount_; i++) begin
        {rst_, data_, expectedState_, expectedDetected_} = testVectors_[i];
        @(negedge clk_);
        #1;

        if (!rst_) begin
          assert (detected_ == expectedDetected_)
            else $error("Wrong output on vector %0d: data = %h", i, data_);
        end

        @(posedge clk_);
        #1;
        assert (stateDbg_ == expectedState_)
          else $error(
              "Wrong state on vector %0d: got %0d, expected %0d",
              i,
              stateDbg_,
              expectedState_
          );
      end
    end
  endtask

endmodule
