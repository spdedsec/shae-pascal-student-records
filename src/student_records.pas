program StudentRecords;

{$mode objfpc}{$H+}

{ shae-pascal-student-records
  Authentic Free Pascal student record management system.
  Features: add, list, search by id/name, delete, save/load to text file.
  Build:  fpc -O2 -o student_records src/student_records.pas
  Run:    ./student_records
}

uses
  SysUtils;

type
  TStudent = record
    Id:   Integer;
    Name: string;
    Grade: Double;
  end;

  TStudents = array of TStudent;

var
  Students: TStudents;
  Count: Integer;

{ -------------------------------------------------------------------------- }
function FindById(const AId: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if Students[i].Id = AId then
    begin
      Result := i;
      Exit;
    end;
end;

{ -------------------------------------------------------------------------- }
procedure AddStudent;
var
  Id: Integer;
  Name: string;
  Grade: Double;
  idx: Integer;
begin
  Write('Enter student id: ');
  ReadLn(Id);
  idx := FindById(Id);
  if idx <> -1 then
  begin
    WriteLn('Error: student with id ', Id, ' already exists.');
    Exit;
  end;
  Write('Enter name: ');
  ReadLn(Name);
  Write('Enter grade: ');
  ReadLn(Grade);
  SetLength(Students, Count + 1);
  Students[Count].Id := Id;
  Students[Count].Name := Name;
  Students[Count].Grade := Grade;
  Inc(Count);
  WriteLn('Student added.');
end;

{ -------------------------------------------------------------------------- }
procedure ListStudents;
var
  i: Integer;
begin
  if Count = 0 then
  begin
    WriteLn('No students.');
    Exit;
  end;
  WriteLn;
  WriteLn('Id  Name              Grade');
  WriteLn('-----------------------------');
  for i := 0 to Count - 1 do
    WriteLn(Students[i].Id:3, '  ', Students[i].Name, '  ', Students[i].Grade:0:2);
end;

{ -------------------------------------------------------------------------- }
procedure SearchById;
var
  Id, idx: Integer;
begin
  Write('Enter id to search: ');
  ReadLn(Id);
  idx := FindById(Id);
  if idx = -1 then
    WriteLn('Student not found.')
  else
    WriteLn(Students[idx].Id:3, '  ', Students[idx].Name, '  ', Students[idx].Grade:0:2);
end;

{ -------------------------------------------------------------------------- }
procedure SearchByName;
var
  Name: string;
  i, found: Integer;
begin
  Write('Enter name to search: ');
  ReadLn(Name);
  found := 0;
  for i := 0 to Count - 1 do
    if SameText(Students[i].Name, Name) then
    begin
      WriteLn(Students[i].Id:3, '  ', Students[i].Name, '  ', Students[i].Grade:0:2);
      Inc(found);
    end;
  if found = 0 then
    WriteLn('No students with name "', Name, '".');
end;

{ -------------------------------------------------------------------------- }
procedure DeleteStudent;
var
  Id, idx, i: Integer;
begin
  Write('Enter id to delete: ');
  ReadLn(Id);
  idx := FindById(Id);
  if idx = -1 then
  begin
    WriteLn('Student not found.');
    Exit;
  end;
  for i := idx to Count - 2 do
    Students[i] := Students[i + 1];
  Dec(Count);
  SetLength(Students, Count);
  WriteLn('Student deleted.');
end;

{ -------------------------------------------------------------------------- }
procedure SaveToFile(const FileName: string);
var
  F: TextFile;
  i: Integer;
begin
  AssignFile(F, FileName);
  Rewrite(F);
  try
    WriteLn(F, Count);
    for i := 0 to Count - 1 do
      WriteLn(F, Students[i].Id, '|', Students[i].Name, '|', FloatToStr(Students[i].Grade));
  finally
    CloseFile(F);
  end;
  WriteLn('Saved ', Count, ' student(s) to ', FileName);
end;

{ -------------------------------------------------------------------------- }
procedure LoadFromFile(const FileName: string);
var
  F: TextFile;
  i, n: Integer;
  Id: Integer;
  Name: string;
  Grade: Double;
  line: string;
  parts: TStringArray;
begin
  if not FileExists(FileName) then
  begin
    WriteLn('File not found: ', FileName);
    Exit;
  end;
  AssignFile(F, FileName);
  Reset(F);
  try
    ReadLn(F, n);
    SetLength(Students, n);
    Count := 0;
    for i := 0 to n - 1 do
    begin
      ReadLn(F, line);
      parts := line.Split(['|']);
      Id := StrToInt(parts[0]);
      Name := parts[1];
      Grade := StrToFloat(parts[2]);
      Students[Count].Id := Id;
      Students[Count].Name := Name;
      Students[Count].Grade := Grade;
      Inc(Count);
    end;
  finally
    CloseFile(F);
  end;
  WriteLn('Loaded ', Count, ' student(s) from ', FileName);
end;

{ -------------------------------------------------------------------------- }
var
  Choice, FileName: string;
begin
  Count := 0;
  SetLength(Students, 0);
  repeat
    WriteLn;
    WriteLn('=== Student Records ===');
    WriteLn('1. Add student');
    WriteLn('2. List all students');
    WriteLn('3. Search by id');
    WriteLn('4. Search by name');
    WriteLn('5. Delete student');
    WriteLn('6. Save to file');
    WriteLn('7. Load from file');
    WriteLn('0. Exit');
    Write('Choice: ');
    ReadLn(Choice);
    if Choice = '1' then
      AddStudent
    else if Choice = '2' then
      ListStudents
    else if Choice = '3' then
      SearchById
    else if Choice = '4' then
      SearchByName
    else if Choice = '5' then
      DeleteStudent
    else if Choice = '6' then
    begin
      Write('File name: ');
      ReadLn(FileName);
      SaveToFile(FileName);
    end
    else if Choice = '7' then
    begin
      Write('File name: ');
      ReadLn(FileName);
      LoadFromFile(FileName);
    end
    else if Choice = '0' then
      WriteLn('Goodbye.')
    else
      WriteLn('Invalid choice.');
  until Choice = '0';
end.
