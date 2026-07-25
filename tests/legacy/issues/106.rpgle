**free

snd-msg 'Hello World';

monitor;
    create_new_account ();
on-excp 'ARV0203' : 'ARV0204';
    // handle two ARV messages
endmon;

arv0203_reptext.badFile = filename;
arv0203_reptext.badIdno = id_no;
SND-MSG %MSG ('ARV0203' : 'ARVMSGS' : arv0203_reptext);

// Send a message to the caller of our main procedure
// - stack offset = 2 since the "caller" is actually the
//   PEP for the program
SND-MSG *ESCAPE 'Unexpected customer type ' + type
                  %TARGET('ARVMAIN' : 2);