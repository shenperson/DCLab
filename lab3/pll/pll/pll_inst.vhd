	component pll is
		port (
			altpll_100k_clk_clk : out std_logic;        -- clk
			altpll_12m_clk_clk  : out std_logic;        -- clk
			clk_clk             : in  std_logic := 'X'; -- clk
			reset_reset_n       : in  std_logic := 'X'  -- reset_n
		);
	end component pll;

	u0 : component pll
		port map (
			altpll_100k_clk_clk => CONNECTED_TO_altpll_100k_clk_clk, -- altpll_100k_clk.clk
			altpll_12m_clk_clk  => CONNECTED_TO_altpll_12m_clk_clk,  --  altpll_12m_clk.clk
			clk_clk             => CONNECTED_TO_clk_clk,             --             clk.clk
			reset_reset_n       => CONNECTED_TO_reset_reset_n        --           reset.reset_n
		);

