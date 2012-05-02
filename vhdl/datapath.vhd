library ieee;
library std;

use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;


-- Datapath

Entity datapath is
    Port(clk        : in std_logic;
         reset      : in std_logic;
         memtoreg   : in std_logic;
         pcsrc      : in std_logic;
         alusrc     : in std_logic;
         regdst     : in std_logic;
         regwrite   : in std_logic;
         jump       : in std_logic;
         alucontrol : in std_logic_vector(2 downto 0);
         instruction: in std_logic_vector(31 downto 0);
         readdata   : in std_logic_vector(31 downto 0);
         pc         : out std_logic_vector(31 downto 0);
         aluout     : out std_logic_vector(31 downto 0);
         writedata  : out std_logic_vector(31 downto 0);
         zero       : out std_logic);
end datapath;

architecture behaviour of datapath is

    component alu
    port(SrcA       : in std_logic_vector(31 downto 0);
         SrcB       : in std_logic_vector(31 downto 0);
         AluControl : in std_logic_vector(2 downto 0);
         AluResult  : out std_logic_vector(31 downto 0);
         Zero       : out std_logic;
         Overflow   : out std_logic;
         CarryOut   : out std_logic);
    end component;
    for alu0: alu use entity work.alu;

    component rf
        port(A1  : in std_logic_vector(4 downto 0);
            A2  : in std_logic_vector(4 downto 0);
            A3  : in std_logic_vector(4 downto 0);
            WD3 : in std_logic_vector(31 downto 0);
            clk : in std_logic;
            We3 : in std_logic;
            RD1 : out std_logic_vector(31 downto 0);
            RD2 : out std_logic_vector(31 downto 0));
    end component;
    for rf0 : rf use entity work.rf;

    component adder
        port(A, B : in std_logic_vector(31 downto 0);
             Y    : out std_logic_vector(31 downto 0));
    end component;
    for pcadder : adder use entity work.adder;
    for pcadder2 : adder use entity work.adder;

    component signextension
        port(A : in std_logic_vector(15 downto 0);
             Y : out std_logic_vector(31 downto 0));
    end component;
    for signext0 : signextension use entity work.signextension;

    component sl2
        port(A : in std_logic_vector(31 downto 0);
            Y : out std_logic_vector(31 downto 0));
    end component;
    for immsh : sl2 use entity work.sl2;

    component mux generic(W : integer);
        port(D0, D1 : in std_logic_vector(W-1 downto 0);
             S      : in std_logic;
             Y      : out std_logic_vector(W-1 downto 0));
    end component;
    for muxregdest : mux use entity work.mux;
    for muxalusrc : mux use entity work.mux;
    for muxaluout : mux use entity work.mux;

    component regaux1
    Generic(W : integer);
    Port (instruction : in std_logic_vector(W-1 downto 0);
          pcplus4     : in std_logic_vector(W-1 downto 0);
          clk         : in std_logic;
          instr_out   : out std_logic_vector(W-1 downto 0);
          pc_out      : out std_logic_vector(W-1 downto 0));
    end component;
    for regpipe1 : regaux1 use entity work.regaux1;

        component regaux2 is
    Generic(W : integer);
    Port (clk           : in std_logic;
          S_RegWriteD   : in std_logic;
          S_MemtoRegD   : in std_logic;
          S_MemWriteD   : in std_logic;
          S_BranchD     : in std_logic_vector(W-1 downto 0);
          S_ALUCOntrolD : in std_logic_vector(2 downto 0);
          S_ALUSrcD     : in std_logic;
          S_RegDstD     : in std_logic;
          RD1           : in std_logic_vector(W-1 downto 0);
          RD2           : in std_logic_vector(W-1 downto 0);
          RtE           : in std_logic_vector(4 downto 0);
          RdE           : in std_logic_vector(4 downto 0);
          SignExt       : in std_logic_vector(W-1 downto 0);
          PCPlus4       : in std_logic_vector(W-1 downto 0);
          outS_RegWriteD   : out std_logic;
          outS_MemtoRegD   : out std_logic;
          outS_MemWriteD   : out std_logic;
          outS_BranchD     : out std_logic_vector(W-1 downto 0);
          outS_ALUCOntrolD : out std_logic_vector(2 downto 0);
          outS_ALUSrcD     : out std_logic;
          outS_RegDstD     : out std_logic;
          outRD1           : out std_logic_vector(W-1 downto 0);
          outRD2           : out std_logic_vector(W-1 downto 0);
          outRtE           : out std_logic_vector(4 downto 0);
          outRdE           : out std_logic_vector(4 downto 0);
          outSignExt       : out std_logic_vector(W-1 downto 0);
          outPCPlus4       : out std_logic_vector(W-1 downto 0));
    end component;
    for regpipe2 : regaux2 use entity work.regaux2;

    component regaux3
    Generic(W : integer);
    Port (clk           : in std_logic;
          S_RegWriteM   : in std_logic;
          S_MemtoRegM   : in std_logic;
          S_MemWriteM   : in std_logic;
          S_BranchM     : in std_logic_vector(W-1 downto 0);
          ZeroM         : in std_logic;
          AluOutM       : in std_logic_vector(W-1 downto 0);
          WriteDataM    : in std_logic_vector(W-1 downto 0);
          WriteRegM     : in std_logic_vector(4 downto 0);
          PcBranchM     : in std_logic_vector(W-1 downto 0);
          outS_RegWriteM   : out std_logic;
          outS_MemtoRegM   : out std_logic;
          outS_MemWriteM   : out std_logic;
          outS_BranchM     : out std_logic_vector(W-1 downto 0);
          outZeroM         : out std_logic;
          outAluOutM       : out std_logic_vector(W-1 downto 0);
          outWriteDataM    : out std_logic_vector(W-1 downto 0);
          outWriteRegM     : out std_logic_vector(4 downto 0);
          outPcBranchM     : out std_logic_vector(W-1 downto 0));
    end component;
    for regpipe3 : regaux3 use entity work.regaux3;

    component regaux4
    Generic(W : integer);
    Port (clk           : in std_logic;
          S_RegWriteW   : in std_logic;
          S_MemtoRegW   : in std_logic;
          ReadDataW     : in std_logic_vector(W-1 downto 0);
          AluOutW       : in std_logic_vector(W-1 downto 0);
          WriteRegW     : in std_logic_vector(4 downto 0);
          outS_RegWriteW : out std_logic;
          outS_MemtoRegW : out std_logic;
          outReadDataW   : out std_logic_vector(W-1 downto 0);
          outAluOutW     : out std_logic_vector(W-1 downto 0);
          outWriteRegW   : out std_logic_vector(4 downto 0));
    end component;
    for regpipe4 : regaux4 use entity work.regaux4;

    Component genericreg is
    Generic(W : integer);
    Port (clk : in std_logic;
          d   : in std_logic_vector(W-1 downto 0);
          q   : out std_logic_vector(W-1 downto 0));
    end component;
    for pcreg : genericreg use entity work.genericreg;

    signal writereg, writerege, writeregm, writeregW  : std_logic_vector(4 downto 0);
    signal instructiond, instructionE, ReadDataW, writedataE, writedM : std_logic_vector(31 downto 0);
    signal memtoregE, memtoregM, memtoregW, alusrcE, memwrite : std_logic;
    signal ZeroE, regwriteE, regwriteM, regwriteW, regdstE : std_logic;
    signal alucontrolE : std_logic_vector(2 downto 0);
    signal pcjump, pcnext, pcnextbr, pcbranchE, pcbranchM, sigimnE, srcae,
           pcplus4, pcbranch, sigimn, aluoutM, aluoutW, pcplus4D, pcplus4E,
           signimsh, srca, srcb, result : std_logic_vector(31 downto 0);
    signal temp : std_logic_vector(31 downto 0);

    begin
        -- IF

        pcjump <= pcplus4(31 downto 28) & instruction(25 downto 0) & "00";
        pcreg : genericreg generic map(32) port map(clk, pcnext, temp); -- pc de fato
        pc <= temp; 
        pcadder : adder port map( temp, X"00000004", pcplus4); -- soma 4 ao pc
        pcbrmux : mux generic map(32) port map(pcplus4, pcbranch, pcsrc, pcnextbr);
        pcmux : mux generic map(32) port map(pcnextbr, pcjump, jump, pcnext); -- mux do pc
        regpipe1 : regaux1 generic map(32) port map(instruction, pcplus4, clk, instructionD, pcplus4D);

        -- ID

        rf0 : rf port map(instructionD(25 downto 21), instructionD(20 downto 16), writereg, result, clk, regwrite, srca, temp); -- Register File
        writedata <= temp;
        signext0: signextension port map(instructionD(15 downto 0), sigimn); -- extende imediato
        immsh : sl2 port map(sigimn, signimsh); -- coloca "00" no final do imediato
        pcadder2 : adder port map(pcplus4, signimsh, pcbranch); -- soma extendido pcplus4
        regpipe2 : regaux2 generic map(32) port map(clk, regwrite, memtoreg, memwrite, pcbranch, alucontrol, alusrc, regdst, srca, temp,
                                    instructionD(20 downto 16), instructionD(15 downto 11), sigimn, pcplus4D,
                                    regwriteE, memtoregE, memwrite, pcbranchE, alucontrolE, alusrcE, regdstE, srcaE, writedataE, 
                                    instructionD(20 downto 16), instructionE(15 downto 11), sigimnE, pcplus4E);

        -- EX

        muxalusrc: mux generic map(32) port map(writedataE, sigimnE, alusrcE, srcb); -- qual entrada de scrb da alu
        muxregdest:mux generic map(5) port map(instructionE(20 downto 16), instructionE(15 downto 11), regdstE, writereg);
        alu0 : alu port map(srca, srcb, alucontrolE, aluout, zeroE); -- verificar se nao precisa de caryout e valores
        aluout <= temp;
        regpipe3 : regaux3 generic map(32) port map(clk, regwriteE, memtoregE, memwrite, pcbranchE, zeroE, temp, writedatae, writereg, pcbranchE,
                                        regwriteM, memtoregM, memwrite, pcbranchM, zero, aluoutM, writedM, writeregM, pcbranchM);

        -- MEM

        regpipe4 : regaux4 generic map(32) port map(clk, regwriteM, memtoregM, readdata, aluoutM, writeregM, regwriteW, memtoregW, readdataW, aluoutW, writeregW);
        -- WB

        muxaluout : mux generic map(32) port map(readdataW, aluoutW, memtoregW, result);


end behaviour;
