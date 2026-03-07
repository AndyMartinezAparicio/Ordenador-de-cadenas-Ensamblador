program OrdenadorCadenas;
{$AsmMode Intel}
{$APPTYPE CONSOLE}

var
  frase: String;
  longitud: Integer;
  cadena: array[0..70] of AnsiChar;


procedure llevar_a_minusculas_sin_tildes; assembler;
asm

   MOV  eax, 0
   MOV  edx, 0                 //inicializamos registros para evitar bugs
   MOV  ecx, longitud          //ecx sera el contador para el loop
   MOV  ebx, ecx               //ebx iterador para el array

 @convertir_en_minuscula:
   DEC  ebx                              //restamos 1 a ebx
   MOVZX eax, byte ptr cadena[ebx]      // accedemos al array desde el final
                           //241 209

   CMP  eax, 209
   JE   @es_ene
   CMP  eax, 241
   JE   @es_ene
   JMP  @no_es_ene_may

 @es_ene:
   MOV  eax, 164            // convertimos Ñ en ñ
   JMP  @push
 @no_es_ene_may:

   CMP  eax, 225
   JNE  @no_es_a
   MOV  eax, 97            //convertimos á en a
   JMP  @push
 @no_es_a:

   CMP  eax, 233
   JNE  @no_es_e
   MOV  eax, 101           //convertimos é en e
   JMP  @push
 @no_es_e:

   CMP  eax, 237
   JNE  @no_es_i
   MOV  eax, 105           //convertimos í en i
   JMP  @push
 @no_es_i:

   CMP  eax, 243
   JNE  @no_es_o           //convertimos ó en o
   MOV  eax, 111
   JMP  @push
 @no_es_o:

   CMP  eax, 250
   JNE  @no_es_u
   MOV  eax, 117           //convertimos ú en u
   JMP  @push
 @no_es_u:

   CMP  eax, 65
   JL   @no_es_mayuscula        //analisamos en el rango si es mayuscula
   CMP  eax, 90
   JG   @no_es_mayuscula
   ADD  eax, 32

 @push:
   MOV  byte ptr cadena[ebx], al   //sustituimos en la cadena original

 @no_es_mayuscula:
   LOOP @convertir_en_minuscula

end;

procedure validar_letras; assembler;
asm
   MOV  eax, 0                   //inicializamos registros para evitar bugs
   MOV  ebx, 0                   //ecx sera el contador para el loop
   MOV  ecx, longitud
 @evaluar_caracteres:

   MOVZX eax, byte ptr cadena[ecx-1]
   CMP  eax, 97                      //analizamos todo el array para ver
   JL   @no_es_letra
   CMP  eax, 164                                   //que sea todo letras minusculas
   JE   @push
   CMP  eax, 122
   JG   @no_es_letra
   @push:
   PUSH eax                     //se pushea a la pila solo si es letra
   INC  ebx                      //incrementamos ebx que sera la nueva longitud
                                //de la cadena
 @no_es_letra:
   LOOP @evaluar_caracteres

   MOV  longitud, ebx            //actualizamos longitud
   MOV  byte ptr cadena[ebx], 0   //ponemos 0 en la ultima posiciond del array
   DEC  ebx                      //restamos 1 a ebx (ebx sera iterador de nuevo)

 @rehacer_cadena:
   POP  eax                        //sacamos de la pila las letras validadas
   MOV  byte ptr cadena[ebx], al
   DEC  ebx
   CMP  ebx, 0                     // se compara con 0 ebx para saber
   JGE  @rehacer_cadena             //cuando terminamos


end;

procedure ordenar_cadena; assembler;
asm

   MOV  eax, 0
   MOV  ebx, 0
   MOV  ecx, longitud       //inicializamos en 0 x si da bug
   CMP  ecx, 1
   JE @no_se_ordena

   DEC  ecx                 //restamos 1 a ecx que sera contador

 @ciclo_1:
   PUSH ecx                //guardamos ecx para restaurarlo luego
   MOV  ecx, longitud       //restablecemos ecx con la longitud original
   DEC  ecx

 @ciclo_2:
   MOVZX eax, byte ptr cadena[ecx]      // tomamos 2 valores de la cadena
   MOVZX ebx, byte ptr cadena[ecx-1]    //ultimo y penultimo

   CMP  bl, al                           //si estan ordenados salta
   JGE  @iterar
   MOV  byte ptr cadena[ecx],bl           //sino c intercambian
   MOV  byte ptr cadena[ecx - 1], al

 @iterar:
   LOOP @ciclo_2
   POP  ecx
   LOOP @ciclo_1

 @no_se_ordena:


end;


procedure quitar_dobles; assembler;
asm
   MOV  eax, 0
   MOV  ebx, 0         //inicializamos para evitar bugs
   MOV  edx, 0
   MOV  ecx, longitud

 @inicio:
   MOVZX eax, byte ptr cadena[ecx-1]     //tomamos ultimo valor
   CMP  eax, ebx              //comparamos primero con 0, luego con el anterior
   JE   @son_iguales           //si son iguales no hace nada
   MOV  ebx, eax              //si son distintos lo agrega a la pila
   PUSH eax
   INC  edx                  //aumentamos edx que sera la nueva longitud
   MOV  longitud, edx
 @son_iguales:
   LOOP @inicio

   MOV  byte ptr cadena[edx], 0
   MOV  eax, 0                  //cremos nueva cadena poniendo 0 al final
   DEC  edx

 @rehacer_cadena:
   POP  eax
   MOV  byte ptr cadena[edx], al
   DEC  edx                      //vamos sacando de la pila y colocando la cadena
   CMP  edx, 0
   JGE  @rehacer_cadena



end;


procedure ordenar_ene; assembler;
asm

   MOV  eax, 0
   MOV  edx, 0                 //inicializamos registros para evitar bugs
   MOV  ecx, longitud          //ecx sera el contador para el loop
   MOV  ebx, 0               //ebx iterador para el array

 @inicio:

   MOVZX eax, byte ptr cadena[ebx]      // accedemos al array desde el inicio
   cmp eax, 164
   JNE @nada            // comprobamos si tiene ñ la cadena

   CMP longitud, 1
   JE @nada            // comprobamos si la ñ esta sola

   @ciclo:
   CMP ecx, 1                    //llevamos la ñ a su lugar
   JE @nada
   INC ebx
   MOVZX edx, byte ptr cadena[ebx]
   CMP edx, 110                               //entre la N y la O
   JG @nada
   MOV byte ptr cadena[ebx], al
   MOV byte ptr cadena[ebx - 1], dl


   loop @ciclo
   @nada:

end;

begin

  Write('Ingrese una frase: ');     //pedimos una frase
  ReadLn(frase);                    //la escaneamos

  longitud := Length(frase);       //  obtenemos la longitud de la frase
  cadena := frase;                 //  la convertimos a un array de char

  llevar_a_minusculas_sin_tildes;           //
  validar_letras;           //  funciones de asm donde llevamos a minusculas
  ordenar_cadena;           //   validamos que sean letras y no c repitan
  quitar_dobles;             //      y se ordena
  ordenar_ene;


  Write('La cadena ordenada es: ');
  Writeln(cadena);          // mostramos en pantalla

  ReadLn(frase);       //scan para que no se desaparezca la consola


end.
