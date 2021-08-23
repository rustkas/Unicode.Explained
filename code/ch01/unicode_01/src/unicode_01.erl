% set console to print unicode
% chcp 65001
-module(unicode_01).

-export([]).

%%
%% Tests
%%
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

% Unicode code point
research_01_test() ->
    Expected = "Cæsar",
    Text = "Caesar as Cæsar",
    Regex = "Cæsar",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, [Result]} = re:run(Text, MP, [{capture, first, list}]),
    ?assertEqual(Expected, Result).

research_02_test() ->
    Expected = [["fiancé"], ["rôle"], ["garçon"]],
    Text = "fiancé, rôle, or garçon",
    Regex = "fiancé|rôle|garçon",
    {ok, MP} = re:compile(Regex, [unicode]),
    {match, Result} = re:run(Text, MP, [global, {capture, first, list}]),
    ?assertEqual(Expected, Result).

research_03_test0() ->
    Data = "fiancé",
    List = unicode:characters_to_list(Data),
    NFC_List = unicode:characters_to_nfc_list(Data),
    NFD_List = unicode:characters_to_nfd_list(Data),
    NFKC_List = unicode:characters_to_nfkc_list(Data),
    NFKD_List = unicode:characters_to_nfkd_list(Data),
    %?debugFmt("List = ~ts",[List]),
    %?debugFmt("NFC List = ~ts",[NFC_List]),
    ?debugFmt("NFD List = ~ts", [NFD_List]),
    %?debugFmt("NFKC List = ~ts",[NFKC_List]),
    ?debugFmt("NFKD List = ~ts", [NFKD_List]),
    ?assertEqual(Data, List),
    %?assertEqual(Data, NFD_List),
    ?assertEqual(Data, NFC_List),
    ?assertEqual(Data, NFKC_List).        %?assertEqual(Data, NFKD_List)

% https://www.evertype.com/alphabets/english.pdf
% Alphabet
% charmap
research_05_test0() ->
    Text =
        "
A a (À à), (Æ æ), B b, C c (Ç ç), D d [Ð ð], E e (É é, È è, Ë ë,
Ê ê), F f, G g, H h, I i (Ï ï), J j, K k, L l, M m, N n (Ñ ñ),
O o (Ö ö, Ô ô), (Œ œ), P p, Q q, R r, S s, T t, U u, V v, W w,
X x, Y y, [Ȝ ȝ], Z z, [Þ þ], [Ƿ ƿ]	
",
    ?debugFmt("Text = ~ts", [Text]).

% https://www.evertype.com/alphabets/english.pdf
% UCS rang
research_06_print_test0() ->
    MakeString = fun(List)->
		String = lists:map(fun(Elem)->
							[Elem] 
						end,List),
		io_lib:format("~ts",[String])	
	end,
	Seq1 = fun()->
	    List = lists:seq(16#40,16#5A),
		MakeString(List)	
	end,
	Seq2 = fun()->
	    List = lists:seq(16#60,16#7A),
		MakeString(List)	
	end,
	Seq3 = fun()->
	    List =[16#C0],
		MakeString(List)	
	end,
	Seq4 = fun()->
	    List = lists:seq(16#C7,16#CB),
		MakeString(List)	
	end,
	Seq5 = fun()->
	    List = [16#CF],
		MakeString(List)	
	end,
	Seq6 = fun()->
	    List = [16#D0],
		MakeString(List)	
	end,
	Seq7 = fun()->
	    List = [16#D1],
		MakeString(List)	
	end,
	Seq8 = fun()->
	    List = [16#D4],
		MakeString(List)	
	end,
	Seq9 = fun()->
	    List = [16#D6],
		MakeString(List)	
	end,
	Seq10 = fun()->
	    List = lists:seq(16#D7,16#DB),
		MakeString(List)	
	end,
	Seq11 = fun()->
	    List = [16#DF],
		MakeString(List)	
	end,
	Seq12 = fun()->
	    List = [16#F1],
		MakeString(List)	
	end,
	Seq13 = fun()->
	    List = [16#F4],
		MakeString(List)	
	end,
	Seq14 = fun()->
	    List = [16#F6],
		MakeString(List)	
	end,
	Seq15 = fun()->
	    List = lists:seq(16#2018,16#2019),
		MakeString(List)	
	end,
	Seq16 = fun()->
	    List = lists:seq(16#201C,16#201D),
		MakeString(List)	
	end,	
	FunctionList = [Seq1,Seq2,Seq3,Seq4,Seq5,Seq6,Seq7,Seq8,Seq9,Seq10,Seq11,Seq12,Seq13,Seq14,Seq15,Seq16],
	StringList = lists:map(fun(Function)-> Function() end,FunctionList),
	String = string:join(StringList,"\r\n"),
	?debugFmt("~n~ts~n",[String]).

research_07_test() ->
Text = "
Examples are: à la carte, abbé, Ægean, archæology, 
belovèd, café, décor, détente, éclair, façade, fête, naïve, naïvety (but cf. 
non-naturalized naïveté), noël, œsophagus, résumé, vicuña. Coöperate and rôle 
are usually written without their diacritics these days.
",
    ?debugFmt("Text = ~ts", [Text]).

-endif.