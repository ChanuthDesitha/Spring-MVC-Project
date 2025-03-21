<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>--%>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <title>User List</title>
    <style>
        /* Base styles and reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f8fa;
            color: #333;
            padding: 30px;
            line-height: 1.6;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Page title */
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #2c3e50;
            font-weight: 600;
            position: relative;
            padding-bottom: 15px;
        }

        h2:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 3px;
            background: linear-gradient(to right, #3498db, #2ecc71);
            border-radius: 3px;
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            background-color: white;
            border-radius: 35px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border: none;
        }

        th {
            background-color: #34495e;
            color: white;
            padding: 16px 12px;
            text-align: left;
            font-weight: 500;
            position: sticky;
            top: 0;
        }

        td {
            padding: 14px 12px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background-color: #f9f9f9;
            transition: background-color 0.2s ease;
        }

        td img {
            border-radius: 50%;
            object-fit: cover;
            display: block;
            margin: 0 auto;
            border: 2px solid #eee;
            transition: transform 0.3s ease;
        }

        td img:hover {
            transform: scale(1.2);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .btn {
            display: inline-block;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-align: center;
        }

        .btn.edit {
            background-color: #3498db;
            color: white;
        }

        .btn.edit:hover {
            background-color: #2980b9;
            box-shadow: 0 4px 10px rgba(52, 152, 219, 0.25);
            transform: translateY(-2px);
        }

        .btn.delete {
            background-color: #e74c3c;
            color: white;
        }

        .btn.delete:hover {
            background-color: #c0392b;
            box-shadow: 0 4px 10px rgba(231, 76, 60, 0.25);
            transform: translateY(-2px);
        }

        a[href="register"] {
            display: inline-block;
            position: absolute;
            top: 15px;
            right: 135px;
            background-color: #2ecc71;
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 30px;
            font-weight: 500;
            margin-bottom: 30px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(46, 204, 113, 0.2);
        }

        a[href="register"]:hover {
            background-color: #27ae60;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(46, 204, 113, 0.3);
        }

        a[href="logout"] {
            position: absolute;
            top: 15px;
            right: 20px;
            display: inline-block;
            background-color: #7f8c8d;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        a[href="logout"]:hover {
            background-color: #95a5a6;
            transform: translateY(-2px);
        }

        td:empty::after {
            content: '--';
            color: #bbb;
        }

        @media screen and (max-width: 768px) {
            body {
                padding: 15px;
            }

            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            th, td {
                padding: 12px 10px;
            }

            .btn {
                padding: 6px 12px;
                font-size: 13px;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        tr {
            animation: fadeIn 0.5s ease forwards;
            animation-delay: calc(var(--index, 0) * 0.05s);
            opacity: 0;
        }

        tr:nth-child(1) { --index: 1; }
        tr:nth-child(2) { --index: 2; }
        tr:nth-child(3) { --index: 3; }
        tr:nth-child(4) { --index: 4; }
        tr:nth-child(5) { --index: 5; }
    </style>
</head>
<body>

<h2>User List</h2>

<table border="1">
  <tr>
    <th>ID</th>
    <th>Name</th>
    <th>Email</th>
    <th>Mobile</th>
    <th>Photo</th>
    <th>Options</th>
  </tr>

    <c:forEach var="user" items="${users}">
        <tr>
            <td>${user.id != null ? user.id : '--'}</td>
            <td>${user.name != null ? user.name : '--'}</td>
            <td>${user.email != null ? user.email : '--'}</td>
            <td>${user.mobile != null ? user.mobile : '--'}</td>
            <td>
                <c:choose>
                    <c:when test="${user.photo == null}">
                        <img src="${pageContext.request.contextPath}/static/img/default.jpg" width="50" height="50" alt="Default Photo"/>
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/photo/${user.id}" width="50" height="50" alt="User Photo"/>
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <a href="${pageContext.request.contextPath}/updateUser?id=${user.id}" class="btn edit">Update</a>
                &nbsp;/&nbsp;
<%--                <a href="deleteuser/${user.id}" class="btn delete"--%>
<%--                   onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>--%>

                <a href="#" class="btn delete" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal"
                   data-href="deleteuser/${user.id}">Delete</a>

            </td>
        </tr>
    </c:forEach>
</table>
<!-- Delete -->
<div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this user?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <a id="confirmDeleteBtn" class="btn btn-danger" href="#">Delete</a>
            </div>
        </div>
    </div>
</div>
<br>
<a href="register">Add New User</a>
<%--<a href="logout" onclick="return confirm('Are you sure you want to logout?')">Logout</a>--%>

<a href="logout" id="logoutButton">Logout</a>

<script>
    document.getElementById("logoutButton").addEventListener("click", function (event) {
        event.preventDefault();

        Swal.fire({
            title: "Are you sure?",
            text: "You will be logged out!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "Yes, logout!"
        }).then((result) => {
            if (result.isConfirmed) {
                fetch("/logout", { method: "GET" }).then(() => {
                    window.location.href = "login";
                });
            }
        });
    });

    //Delete
    document.addEventListener("DOMContentLoaded", function () {
        var confirmDeleteModal = document.getElementById("confirmDeleteModal");
        confirmDeleteModal.addEventListener("show.bs.modal", function (event) {
            var button = event.relatedTarget;
            var deleteUrl = button.getAttribute("data-href");
            var confirmDeleteBtn = document.getElementById("confirmDeleteBtn");
            confirmDeleteBtn.setAttribute("href", deleteUrl);
        });
    });
</script>

</body>
</html>
