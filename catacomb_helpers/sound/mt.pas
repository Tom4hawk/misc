program catacomb_music;

Uses
	SPKlib;

Const
	dupa = 'cycki';

Type
	soundtype = (nosnd,blockedsnd,itemsnd,treasuresnd,bigshotsnd,shotsnd,
	    tagwallsnd,tagmonsnd,tagplayersnd,killmonsnd,killplayersnd,opendoorsnd,
		potionsnd,spellsnd,noitemsnd,gameoversnd,highscoresnd,leveldonesnd,
		foundsnd);

Procedure Paralign;
Var
  state: record
    case boolean of
      true: (p: pointer);
      false: (offset,segment:word);
    End;
Begin
  mark (state.p);
  If state.offset>0 then
    Begin
      state.offset:=0;
      inc(state.segment);
      release (state.p);
    end;
end;

Procedure PlaySound (soundnum: soundtype);
Begin
	PlaySound1 (integer(soundnum));
End;

function Bload (filename: string): pointer;
var
  iofile: file;
  len: longint;
  allocleft,recs: word;
  into,second: pointer;
begin
  Assign (iofile,filename);
  Reset (iofile,1);
  If ioresult<>0 then
    Begin
      writeln ('File not found: ',filename);
      halt;
    End;

  len:=filesize(iofile);
  paralign;

  if len>$fff0 then      {do this crap because getmem can only give $FFF0}
    begin
      getmem (into,$fff0);
      BlockRead (iofile,into^,$FFF0,recs);
      allocleft:=len-$fff0;
      while allocleft > $fff0 do
	begin
	  getmem (second,$fff0);
	  BlockRead (iofile,second^,$FFF0,recs);
	  allocleft:=allocleft-$fff0;
	end;
      getmem (second,allocleft);
      BlockRead (iofile,second^,$FFF0,recs);
    end
  else
    begin
      getmem (into,len);
      BlockRead (iofile,into^,len,recs);
    end;

  Close (iofile);
  bload:=into;
end;

Procedure LoadSounds;
Begin
  SoundData:=Bload ('SOUNDS.CAT');
End;

Begin
	writeln(dupa);
	LoadSounds;
	StartupSound;

	
	playsound (nosnd);
	waitendsound;
	playsound (blockedsnd);
	waitendsound;
	playsound (itemsnd);
	waitendsound;
	playsound (treasuresnd);
	waitendsound;
	playsound (bigshotsnd);
	waitendsound;
	playsound (shotsnd);
	waitendsound;
	playsound (tagwallsnd);
	waitendsound;
	playsound (tagmonsnd);
	waitendsound;
	playsound (tagplayersnd);
	waitendsound;
	playsound (killmonsnd);
	waitendsound;
	playsound (killplayersnd);
	waitendsound;
	playsound (opendoorsnd);
	waitendsound;
	playsound (potionsnd);
	waitendsound;
	playsound (spellsnd);
	waitendsound;
	playsound (noitemsnd);
	waitendsound;
	playsound (gameoversnd);
	waitendsound;
	playsound (highscoresnd);
	waitendsound;
	playsound (leveldonesnd);
	waitendsound;
	playsound (foundsnd);
	waitendsound;

		playsound (highscoresnd);
	waitendsound;

		playsound (highscoresnd);
	waitendsound;

		playsound (highscoresnd);
	waitendsound;

		playsound (highscoresnd);
	waitendsound;

	ShutdownSound;

End.