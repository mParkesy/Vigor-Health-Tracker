<%-- 
    Document   : weight
    Created on : 08-Mar-2018, 12:33:25
    Author     : xze15agu
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

                var ctx = document.getElementById("weightChart").getContext('2d');
                var myLineChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        datasets: [
                            {
                                label: "Weight",
                                backgroundColor: "rgba(66, 224, 197, 0.15)",
                                borderColor: "rgba(66, 224, 197, 30)",
                                data: [
            <c:forEach items="<%=db.allWeight(currentUser.getID())%>" var="w">
                                    {x: "${w.getDay()}/${w.getMonth()+1}/${w.getYear()}", y: ${w.getWeight()}},
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
        <!--<div class="graph" id="chartContainer" style="height: 300px;"></div> -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4>Add to Weight Log</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body modal-form">
                        <form class="modal-form" method ="post" action="WeightController">
                            <input type="hidden" name="userID" value="${user.getID()}">
                            <div class="form-group">
                                <label for="weight">Weight:</label>
                                <input type="number" class="form-control" step="0.1" name="weight" required>
                            </div>
                            <div class="form-group">
                                <label for="date">Date:</label>
                                <input id="datefield" max="" type="date" class="form-control" name="date" required>
                            </div>
                            <button type="submit" class="btn btn-info">Add Weight</button>
                        </form>    
                    </div>

                </div>
            </div>
        </div>
        <div class="row">
            <div class=" col-lg-3 col-md-2 col-sm-1"></div>
            <div class="col-lg-6 col-md-8 col-sm-10 main">
                <h1>Weight History</h1>        
                ${message}
                <canvas id="weightChart" ></canvas>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Weight(kg)</th>
                            <th>Date</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="<%=db.allWeight(currentUser.getID())%>" var="w">
                            <tr>
                                <td>
                                    ${w.getWeight()}
                                </td>
                                <td>
                                    ${w.getDate()}
                                </td>
                                <td>
                                    <form action="WeightController"  class="modal-form">
                                        <input type="hidden" name="weightID" value="${w.getWeightID()}">
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
                    Add Weight
                </button>
            </div>
            <div class=" col-lg-3 col-md-2 col-sm-1"></div>
        </div>
    </body>
</html>

