<%-- 
    Document   : sleep
    Created on : 08-Mar-2018, 23:38:34
    Author     : 100116544
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="classes.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="fragments/header.jspf" %> 
        <script>
            $(document).ready(function () {
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!
            var yyyy = today.getFullYear();
            if (dd < 10) {
            dd = '0' + dd
            }
            if (mm < 10) {
            mm = '0' + mm
            }

            today = yyyy + '-' + mm + '-' + dd;
            document.getElementById("datefield").setAttribute("max", today);
            var ctx = document.getElementById("sleepChart").getContext('2d');
            var myLineChart = new Chart(ctx, {
            type: 'line',
                    data: {
                    datasets: [
                    {
                    label: "Sleep",
                            backgroundColor: "rgba(66, 224, 197, 0.15)",
                            borderColor: "rgba(66, 224, 197, 30)",
                            data: [
            <c:forEach items="<%=db.allSleep(currentUser.getID())%>" var="s">
                            {x: "${s.getDay()}/${s.getMonth()}/${s.getYear()}", y: ${s.getTotalSleep()}},
            </c:forEach>
                                                ]
                                        },
                                        {
                                        label: 'Grade',
                                                backgroundColor: "rgba(24, 76, 63, 0)",
                                                borderColor: "rgba(56, 165, 134, 30)",
                                                data: [
            <c:forEach items="<%=db.allSleep(currentUser.getID())%>" var="s">
                                                {x: "${s.getDay()}/${s.getMonth()}/${s.getYear()}", y: ${s.getSleepGrade()}},
            </c:forEach>
                                                                    ]
                                                            }
                                                            ]
                                                            },
                                                            options: {
                                                            lineTension: 0,
                                                                    responsive: true,
                                                                    scales: {
                                                                    xAxes: [{
                                                                    type: "time",
                                                                            time: {
                                                                            format: 'DD/MM/YYYY',
                                                                                    unit: 'day'
                                                                            }
                                                                    }]
                                                                    }
                                                            }
                                                    });
                                                    });
        </script>
    </head>
    <body>
        <%@ include file="fragments/navbar.jspf" %>
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4>Add to Sleep Log</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body modal-form">
                        <form method ="post" action="SleepController">
                            <input type="hidden" name="userID" value="${user.getID()}">
                            <div class="form-group">
                                <label for="bedtime">Bed Time:</label>
                                <input type="date" id="datefield" max="" class="form-control"  name="bedDate" required>
                            </div>
                            <div class="form-group">
                                <input type="time" class="form-control"  name="bedTime" required>
                            </div>
                            <div class="form-group">
                                <label for="bedtime">Wake Time:</label>
                                <input type="time" class="form-control"  name="wakeTime" required>
                            </div>
                            <div class="form-group">
                                <label for="bedtime">Grade your sleep from 1-10:</label>
                                <input type="number" class="form-control"  min="1" max="10" name="sleepGrade" required>
                            </div>
                            <button type="submit" class="btn btn-info">Add Sleep</button>
                        </form>   
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class=" col-lg-3 col-md-2 col-sm-1"></div>
            <div class="col-lg-6 col-md-8 col-sm-10 main">
                <h1>Sleep History</h1>
                ${message}
                <canvas id="sleepChart" ></canvas>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Amount of sleep</th>
                            <th>Sleep Grade</th>
                            <th>Date</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="<%=db.allSleep(currentUser.getID())%>" var="s">
                            <tr>  
                                <td>
                                    ${s.getTotalSleep()} hours
                                </td>
                                <td>
                                    ${s.getSleepGrade()}
                                </td>
                                <td>
                                    ${s.getDateOfSleep()}
                                </td> 
                                <td>
                                    <form action="SleepController"  class="modal-form">
                                        <input type="hidden" name="sleepID" value="${s.getSleepID()}">
                                        <button type="submit" class="btn btn-danger add-small">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <button type="button" class="btn btn-info btn-lg"
                        data-toggle="modal" data-target="#myModal">
                    Add Sleep
                </button>
            </div>
            <div class=" col-lg-3 col-md-2 col-sm-1"></div>
        </div>
    </body>

</html>