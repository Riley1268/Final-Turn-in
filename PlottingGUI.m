function [] = PlottingGUI()
global graph;

graph.fig = figure( 'numbertitle', 'off', 'name', 'Plot Graph');
% creates the figure

graph.xinputText = uicontrol('style', 'text', 'units', 'normalized', 'position', [.01 .95 .20 .05], 'string', 'x values:', 'horizontalalignment', 'left');
graph.xinput = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.01 .90 .10 .05]);
graph.yinputText  = uicontrol('style', 'text', 'units', 'normalized', 'position', [.01 .85 .20 .05], 'string', 'y values:', 'horizontalalignment', 'left');
graph.yinput = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.01 .80 .10 .05]);
% Addes x and y input boxes with labels 

graph.runButton = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.01 .50 .05 .05], 'Callback', {@plotting});
graph.runButtonText = uicontrol('style', 'text', 'units', 'normalized', 'position', [.01 .55 .10 .05], 'string', 'Run', 'horizontalalignment', 'left');
graph.resetButton = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.01 .40 .10 .05], 'Callback', {@clearPlot});
graph.resetButtonText = uicontrol('style', 'text', 'units', 'normalized', 'position', [.01 .45 .10 .05], 'string', 'Reset', 'horizontalalignment', 'left');
%Runs the values you input 
% Clears the graph and all input boxes 

graph.xMin = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.20 .10 .05 .05]);
graph.xminText = uicontrol('style', 'text', 'units', 'normalized', 'position', [.12 .06 .08 .08], 'string', 'x min:', 'horizontalalignment', 'right');
graph.xMax = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.68 .10 .05 .05]);
graph.xmaxText = uicontrol('style', 'text', 'units', 'normalized', 'position', [.60 .06 .08 .08], 'string', 'x max:', 'horizontalalignment', 'right');
graph.yMin = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.77 .20 .05 .05]);
graph.yminText = uicontrol('style', 'text', 'units', 'normalized', 'position', [.70 .18 .07 .06], 'string', 'y min:', 'horizontalalignment', 'right');
graph.yMax = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.77 .65 .05 .05]);
graph.ymaxText = uicontrol('style', 'text', 'units', 'normalized', 'position', [.70 .63 .07 .06], 'string', 'y max:', 'horizontalalignment', 'right');
% Creates graph limits with labels 

graph.buttonGroupColor = uibuttongroup ('Visible', 'on', 'units', 'normalized', 'position', [.6 .8 .4 .2]);
graph.r1 = uicontrol(graph.buttonGroupColor, 'style', 'radiobutton', 'string', 'r', 'units', 'normalized', 'position', [.1 .4 .3 .2], 'HandleVisibility', 'off');
graph.r2 = uicontrol(graph.buttonGroupColor, 'style', 'radiobutton', 'string', 'g', 'units', 'normalized', 'position', [.3 .4 .3 .2], 'HandleVisibility', 'off');
graph.r3 = uicontrol(graph.buttonGroupColor, 'style', 'radiobutton', 'string', 'k', 'units', 'normalized', 'position', [.5 .4 .3 .2], 'HandleVisibility', 'off');
% Addes buttons to top right to change color of graph

graph.buttonGroupStyle = uibuttongroup('Visible', 'on', 'units', 'normalized', 'position', [.85 .2 .15 .2]);
graph.b1 = uicontrol(graph.buttonGroupStyle, 'style', 'radiobutton', 'string', '-', 'units', 'normalized', 'position', [.1 .5 .4 .3], 'HandleVisibility', 'off');
graph.b2 = uicontrol(graph.buttonGroupStyle, 'style', 'radiobutton', 'string', '--', 'units', 'normalized', 'position', [.1 .25 .3 .3], 'HandleVisibility', 'off');
graph.b3 = uicontrol(graph.buttonGroupStyle, 'style', 'radiobutton', 'string', ':', 'units', 'normalized', 'position', [.1 .02 .4 .3], 'HandleVisibility', 'off');
% Buttons to change line type 

graph.titleText = uicontrol('style', 'text', 'units', 'normalized', 'position', [.25 .7 .20 .05], 'string', 'Title:');
graph.title = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.4 .71 .10 .05]);
% box for graph title 

graph.xaxisText = uicontrol('style', 'text', 'units', 'normalized', 'position', [.26 .08 .20 .05], 'string', 'x Axis:');
graph.xaxis = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.4 .09 .10 .05]);
% labels x-axis

graph.yaxisText = uicontrol('style', 'text', 'units', 'normalized', 'position', [.7 .45 .1 .05], 'string', 'y Axis:');
graph.yaxis = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.79 .46 .10 .05]);
% labels y-axis

graph.p = plot (0,0);
graph.p.Parent.Units = 'Normalized';
graph.p.Parent.Position = [0.2 0.2 0.5 0.5];
%Plots the original empty graph on the figure.

    function [] = plotting(~,~)
        if length(graph.xinput) == 0 || length(graph.yinput) == 0
            return;
        end
        xVals = str2num(graph.xinput.String);
        yVals = str2num(graph.yinput.String);
        %needed to change the string into numbers that can be plotted 
     
        expOne = '[0-9]*(\.[0-9])?(,[0-9])?';
        resultX = regexp(graph.xinput.String, expOne, 'match');
        resultY = regexp(graph.yinput.String, expOne, 'match');
        %regexp to check that no inputs are nonintegers, and returns an error if there are any
        
        if length(xVals) ~= length(yVals)
            msgbox('Invalid Input!', 'Plotting Error', 'error', 'modal');
            return;
            %if number of x inputs doesn't equal number of y.  It will
            %return error
        elseif length(resultX) == 0 || length(resultY) == 0
            msgbox('Invalid Inputs.', 'Plotting Error', 'error', 'modal');
            return;      
%             If there's no inputs it returns error
        else
          lineColor = graph.buttonGroupColor.SelectedObject.String;
          lineStyle = graph.buttonGroupStyle.SelectedObject.String;
            %sets variables equal to line color and style the user choses
          graph.p = plot(xVals, yVals, [lineColor lineStyle]);
%           Graphs everything on the empty plot 
        end
                   
           expTwo = '[0-9]*(\.[0-9])?';
        resultXmin = regexp(graph.xMin.String, expTwo, 'match');
        resultXmax = regexp(graph.xMax.String, expTwo, 'match');
        %regexp to check if inputs are nonintegers 
      
        if length(graph.xMin.String) == 0 || length(graph.xMax.String) == 0
            return;
            %If there is no input, it will continue to graph the x and y
            %function
        end
        
       if str2num(graph.xMax.String) < str2num(graph.xMin.String)
          msgbox('Invalid Limits.', 'Plotting Error', 'error', 'modal');
          %If max<min return error
           return;
       elseif length(resultXmin) == 0 || length(resultXmax) == 0
            msgbox('Invalid Limits.', 'Plotting Error', 'error', 'modal');
            return;
           %checks for noninteger inputs on the max and min of the graph 
       else 
            xMinimum = str2double(graph.xMin.String);
            xMaximum = str2double(graph.xMax.String);
            xlim([xMinimum, xMaximum]);
       end     
                  expThree = '[0-9]*(\.[0-9])?';
        resultYmin = regexp(graph.yMin.String, expThree, 'match');
        resultYmax = regexp(graph.yMax.String, expThree, 'match');
        %returns error if inouts are nonintegers 
       
               if length(graph.yMin.String) == 0 || length(graph.yMax.String) == 0
            %function will continue to graph the x and y inputs without a
            %user-specified limit if no inputs are given.
                   return;
        end
        
       if str2num(graph.yMax.String) < str2num(graph.yMin.String)
          msgbox('Invalid Limits.', 'Plotting Error', 'error', 'modal');
          %returns error if max input> min input
           return;
       elseif length(resultYmin) == 0 || length(resultYmax) == 0
           msgbox('Invalid Limits.', 'Plotting Error', 'error', 'modal');
           return;          
       else 
            yMinimum = str2double(graph.Ymin.String);
            yMaximum = str2double(graph.Ymax.String);
            ylim([yMinimum, yMaximum]);
       end
                        
    end

    function [] = clearPlot(~,~)
        graph.p = plot(0,0);
        graph.xinput.String = '';
        graph.yinput.String = '';
        graph.xMin.String = '';
        graph.xMax.String = '';
        graph.yMin.String = '';
        graph.yMax.String = '';
        graph.xaxis.String = '';
        graph.yaxis.String = '';
        graph.title.String = '';
        %clears all edit boxes
    end
        
end
