/// @file name_mealy_fsm.sv
/// @brief Автомат Мили для распознавания имени ANTON.
///

/// @param[in] clk_ Тактовый сигнал.
/// @param[in] rst_ Синхронный сброс.
/// @param[in] data_ Входной ASCII-символ.
/// @param[out] detected_ Признак распознавания имени.
/// @param[out] stateDbg_ Текущее состояние для отладки.
module name_mealy_fsm (
    input  logic       clk_,
    input  logic       rst_,
    input  logic [7:0] data_,
    output logic       detected_,
    output logic [2:0] stateDbg_
);

  localparam logic [7:0] CH_A = 8'h41;
  localparam logic [7:0] CH_N = 8'h4E;
  localparam logic [7:0] CH_T = 8'h54;
  localparam logic [7:0] CH_O = 8'h4F;

  localparam logic [2:0] S0 = 3'b000;  ///< ""
  localparam logic [2:0] S1 = 3'b001;  ///< "A"
  localparam logic [2:0] S2 = 3'b010;  ///< "AN"
  localparam logic [2:0] S3 = 3'b011;  ///< "ANT"
  localparam logic [2:0] S4 = 3'b100;  ///< "ANTO"

  logic [2:0] currentState;
  logic [2:0] nextState;

  always @(*) begin
    nextState = S0;
    detected_ = 1'b0;

    case (currentState)
      S0: nextState = (data_ == CH_A) ? S1 : S0;
      S1: nextState = (data_ == CH_N) ? S2 : (data_ == CH_A) ? S1 : S0;
      S2: nextState = (data_ == CH_T) ? S3 : (data_ == CH_A) ? S1 : S0;
      S3: nextState = (data_ == CH_O) ? S4 : (data_ == CH_A) ? S1 : S0;
      S4: begin
        nextState = (data_ == CH_A) ? S1 : S0;
        detected_ = (data_ == CH_N);
      end
      default: nextState = S0;
    endcase
  end

  always @(posedge clk_) begin
    if (rst_) currentState <= S0;
    else currentState <= nextState;
  end

  assign stateDbg_ = currentState;

endmodule
