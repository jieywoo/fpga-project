----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
--           Jieyeon Woo, Olivia Messina
-- 
-- Controleur du Jeu
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.pong_pack_2.ALL;


entity game is
	Port(
			clk25 : in  STD_LOGIC;										-- Horloge
         reset : in  STD_LOGIC;										-- Reset Asynchrone
         press: in STD_LOGIC;											-- Appui Bouton Encodeur
			endframe : in  STD_LOGIC;									-- Fin de l'Image Visible
         visible : in  STD_LOGIC;									-- Zone Visible de l'Image
         wall : in  STD_LOGIC;										-- Pixel Courant = Mur
         bottom : in  STD_LOGIC;										-- Pixel Courant = Bas de l'Ecran
         bluebox : in  STD_LOGIC;									-- Pixel Courant = Case Bleue
			pad : in  STD_LOGIC;											-- Pixel Courant = Raquette
         ball : in  STD_LOGIC;										-- Pixel Courant = Balle
			brick : in  tableau;											-- Pixel Courant = Brique
         brick_bounce : in tableau;									-- Rebond Contre une Brique
         red : out  STD_LOGIC;										-- Affichage Rouge
         green : out  STD_LOGIC;										-- Affichage Vert
         blue : out  STD_LOGIC;										-- Affichage Bleu
         miss_timer : out  STD_LOGIC_VECTOR (5 downto 0);	-- Timer Mode Partie Perdue
         freeze : out  STD_LOGIC; -- Mode Pause
         xpos, ypos: in STD_LOGIC_VECTOR(9 downto 0); 
         brick_break: in natural);									

end game;

architecture Behavioral of game is

signal win : STD_LOGIC;
signal miss : STD_LOGIC;

begin

	-- SELECTION DES COULEURS DEX PIXELS
	color_select: entity work.display
			port map (
				pad 		=> pad,			-- Pixel Courant = Raquette
				wall 		=> wall,			-- Pixel Courant = Mur
				bluebox 	=> bluebox,		-- Pixel Courant = Case Bleue
				ball		=> ball,			-- Pixel Courant = Balle
				brick 	=> brick,		-- Pixel Courant = Brique
				win 		=> win,			-- Partie Gagnee
				miss 		=> miss,			-- Partie Perdue
				red 		=> red,			-- Affichage Rouge
				green 	=> green,		-- Affichage Vert
				blue 		=> blue,			-- Affichage Bleu
				xpos => xpos,
                ypos => ypos,
                brick_break => brick_break
			);

	-- CONTROLEUR DE JEU
	mode_ctrl: entity work.mode
			port map (
				clk25 			=> clk25,			-- Horloge 25 MHz
				reset 			=> reset,			-- Reset Asynchrone
				press 			=> press,			-- Appui sur le Bouton
				endframe 		=> endframe,		-- Fin de l'Image Visible
				visible 			=> visible,			-- Zone Visible de l'Image
				ball				=> ball,				-- Pixel Courant = Balle
				bottom 			=> bottom,			-- Pixel Courant = Bas de L'Ecran
				brick_bounce 	=> brick_bounce,	-- Rebond Contre une Brique
				miss_timer 		=> miss_timer,		-- Timer du Mode Partie Perdue				
				miss 				=> miss,				-- Partie Perdue
				win 				=> win,				-- Partie Gagnee
				freeze 			=> freeze			-- Mode Pause
			);


end Behavioral;

