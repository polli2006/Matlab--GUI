function varargout = first(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @first_OpeningFcn, ...
                   'gui_OutputFcn',  @first_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before first is made visible.
function first_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes first wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = first_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in Retry.
function Retry_Callback(hObject, eventdata, handles)
cla;
set(handles.laxes, 'Color', 'w');
set(handles.Show_safe, 'Enable', 'inactive');
set(handles.Retry, 'Enable', 'inactive');
set(handles.Start, 'Enable', 'inactive');
set(handles.Place_targets, 'Enable', 'on');
set(handles.Color_b, 'Enable', 'inactive');
set(handles.Color_gb, 'Enable', 'inactive');
set(handles.Border_b, 'Enable', 'inactive');
set(handles.Bombs, 'Enable', 'inactive');


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
set(handles.Color_b, 'Enable', 'on');
set(handles.Bombs, 'Enable', 'on');
set(handles.Color_gb, 'Enable', 'on');
set(handles.Border_b, 'Enable', 'on');
set(handles.Start, 'Enable', 'inactive');
X = str2double(get(handles.X, 'String'));
Y = str2double(get(handles.Y, 'String'));
M = str2double(get(handles.M, 'String'));
N = str2double(get(handles.N, 'String'));
r = str2double(get(handles.r, 'String'));
z = 0;
ksi = z + (X - z) * rand(1, N);
eta = z + (Y - z) * rand(1, N);
x = handles.new_x;
y = handles.new_y;
phi = 0 : 0.05 : 2 * pi;
x_bord = r * cos(phi);
y_bord = r * cos(phi);
for j = 1 : M
    x_bord = x(j) + r * cos(phi);
    y_bord = y(j) + r * sin(phi);
    color = (get(handles.Color_b,'String'));
    fill(x_bord, y_bord, color);
    color = (get(handles.Color_gb,'String'));
    plot(x_bord, y_bord, color);
end
fish = zeros(1, N);
for i = 1 : N
    for j = 1 : M
        
        if ((x(j) - ksi(i)) * (x(j) - ksi(i)) + (y(j) - eta(i)) * (y(j) - eta(i)) <= r * r)
            fish(i) = 1;
        end
    end
end
count = 0;
for i = 1 : N
    if (fish(i) == 1)
        count = count + 1;
    end
end
plot(ksi, eta, 'y*');
l = int2str(count);
set(handles.Dead, 'String', l);
set(handles.Retry, 'Enable', 'on');
set(handles.Show_safe, 'Enable', 'on');
handles.mas = fish;
handles.fish_x = ksi;
handles.fish_y = eta;
guidata(handles.Start, handles);

function Place_targets_Callback(hObject, eventdata, handles)
set(handles.Show_safe, 'Enable', 'inactive');
set(handles.Retry, 'Enable', 'inactive');
X = str2double(get(handles.X, 'String'));
Y = str2double(get(handles.Y, 'String'));
M = str2double(get(handles.M, 'String'));
N = str2double(get(handles.N, 'String'));
r = str2double(get(handles.r, 'String'));
set(handles.laxes, 'XLim', [0 X]);
set(handles.laxes, 'YLim', [0 Y]);
color = get(handles.Color_f,'String');
set(handles.laxes, 'Color', color);
color = get(handles.Color_gf,'String');
l1 = get(handles.Border_f, 'String');
color = strcat(color, l1);
n = 100;
l1 = 0 : X/n : X;
l2 = 0 : Y/n : Y;
l3 = ones(1, n + 1) * Y;
l4 = ones(1, n + 1) * X;
l5 = zeros(1, n + 1);
plot(l1, l5,color);
plot(l1, l3,color);
plot(l5, l2,color);
plot(l4, l2,color);
[x, y] = ginput(M);
plot(x, y, '*');
handles.new_x = x;
handles.new_y = y;
guidata(handles.Place_targets, handles);
set(handles.Start, 'Enable', 'on');
set(handles.Place_targets, 'Enable', 'inactive');

function Y_Callback(hObject, eventdata, handles)
function X_Callback(hObject, eventdata, handles)

function M_Callback(hObject, eventdata, handles)
function r_Callback(hObject, eventdata, handles)

function Show_safe_Callback(hObject, eventdata, handles)
X = str2double(get(handles.X, 'String'));
Y = str2double(get(handles.Y, 'String'));
M = str2double(get(handles.M, 'String'));
N = str2double(get(handles.N, 'String'));
set(handles.Slider, 'Value',N);
r = str2double(get(handles.r, 'String'));
fx = handles.fish_x;
fy = handles.fish_y;
fish = handles.mas;
color = get(handles.Color,'String');
set(handles.laxes, 'Color', color);
for i = 1 : N
    if (fish(i) == 0) 
        plot(fx(i), fy(i), '*y');
    end
    if (fish(i) == 1)
        plot(fx(i), fy(i), '*c');
    end
end
function Bombs_Callback(hObject, eventdata, handles) 
X = str2double(get(handles.X, 'String'));
Y = str2double(get(handles.Y, 'String'));
M = str2double(get(handles.M, 'String'));
N = str2double(get(handles.N, 'String'));
r = str2double(get(handles.r, 'String'));
fx = handles.fish_x;
fy = handles.fish_y;
fish = handles.mas;
x = handles.new_x;
y = handles.new_y;
phi = 0 : 0.05 : 2 * pi;
for j = 1 : M
    x_bord = x(j) + r * cos(phi);
    y_bord = y(j) + r * sin(phi);
    color = (get(handles.Color_b,'String'));
    fill(x_bord, y_bord, color);
    color = (get(handles.Color_gb,'String'));
    l1 = get(handles.Border_b,'String');
    color = strcat(color, l1);
    plot(x_bord, y_bord, color);
end
ksi = handles.fish_x;
eta = handles.fish_y;
l1='y';
l2='*';
l1=strcat(l1,l2);
plot(ksi, eta, l1);

function Dead_Callback(hObject, eventdata, handles)

function N_Callback(hObject, eventdata, handles)
N = str2double(get(handles.N, 'String'));
set(handles.Slider, 'Value',N);


function Color_Callback(hObject, eventdata, handles)
% hObject    handle to ll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ll as text
%        str2double(get(hObject,'String')) returns contents of ll as a double


% --- Executes during object creation, after setting all properties.
function ll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Color_gf_Callback(hObject, eventdata, handles)
% hObject    handle to Color_gf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Color_gf as text
%        str2double(get(hObject,'String')) returns contents of Color_gf as a double


% --- Executes during object creation, after setting all properties.
function Color_gf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Color_gf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Color_f_Callback(hObject, eventdata, handles)
% hObject    handle to Color_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Color_f as text
%        str2double(get(hObject,'String')) returns contents of Color_f as a double


% --- Executes during object creation, after setting all properties.
function Color_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Color_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Border_f_Callback(hObject, eventdata, handles)
% hObject    handle to Border_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Border_f as text
%        str2double(get(hObject,'String')) returns contents of Border_f as a double


% --- Executes during object creation, after setting all properties.
function Border_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Border_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Border_b_Callback(hObject, eventdata, handles)
% hObject    handle to Border_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Border_b as text
%        str2double(get(hObject,'String')) returns contents of Border_b as a double


% --- Executes during object creation, after setting all properties.
function Border_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Border_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Color_b_Callback(hObject, eventdata, handles)
% hObject    handle to Color_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Color_b as text
%        str2double(get(hObject,'String')) returns contents of Color_b as a double


% --- Executes during object creation, after setting all properties.
function Color_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Color_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Color_gb_Callback(hObject, eventdata, handles)
% hObject    handle to Color_gb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Color_gb as text
%        str2double(get(hObject,'String')) returns contents of Color_gb as a double


% --- Executes during object creation, after setting all properties.
function Color_gb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Color_gb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
x = get(handles.Slider, 'Value');
set(handles.N, 'String',num2str(round(x)));

% --- Executes during object creation, after setting all properties.
function Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function N_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
