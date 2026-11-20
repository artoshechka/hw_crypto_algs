`timescale 1ns / 1ns

module tb_name_mealy_fsm;
  logic       clk_ = 1'b0;
  logic       rst_ = 1'b0;
  logic [7:0] data_;
  logic       detected_;
  logic [2:0] stateDbg_;
  logic [7:0] name_       [0:4];

  name_mealy_fsm dut (
      .clk_(clk_),
      .rst_(rst_),
      .data_(data_),
      .detected_(detected_),
      .stateDbg_(stateDbg_)
  );

  always #5 clk_ = ~clk_;

  initial begin
    name_[0] = "A";
    name_[1] = "N";
    name_[2] = "T";
    name_[3] = "O";
    name_[4] = "N";

    $dumpfile("work/wave.ocd");
    $dumpvars(0, tb_name_mealy_fsm);

    for (int state = 0; state < 5; state++) begin
      goToState(state);

      checkTransition(name_[state], state == 4, state == 4 ? 3'd0 : state + 1);

      if (state != 0) begin
        goToState(state);
        checkTransition("A", 1'b0, 3'd1);
      end

      goToState(state);
      checkTransition("X", 1'b0, 3'd0);
    end

    $display("All FSM transition tests passed.");
    $finish;
  end

  task resetDut;
    begin
      rst_ = 1'b1;
      @(posedge clk_);
      #1;
      assert (stateDbg_ == 3'd0)
      else $error("Reset did not enter S0");
      rst_ = 1'b0;
      #1;
    end
  endtask

  task checkTransition;
    input [7:0] charIn;
    input expectedDetected;
    input [2:0] expectedState;
    begin
      @(negedge clk_);
      data_ = charIn;
      #1;
      assert (detected_ == expectedDetected)
      else $error("Wrong output on %c", charIn);
      @(posedge clk_);
      #1;
      assert (stateDbg_ == expectedState)
      else $error("Wrong state after %c", charIn);
    end
  endtask

  task goToState;
    input integer targetState;
    begin
      resetDut();
      for (int i = 0; i < targetState; i++) begin
        checkTransition(name_[i], 1'b0, i + 1);
      end
    end
  endtask

endmodule
