// Import required modules
const express = require('express');
const oracledb = require('oracledb');
const bodyParser = require('body-parser');
const cors = require('cors');
//const nodemailer = require('nodemailer');

// Create Express app
const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Oracle Database connection configuration
const dbConfig = {
  user: 'PROJECT1',
  password: 'project123',
  connectString: 'ORCL',
};
//=================================order details insert==================================================
app.post('/api/insert/orderdetails', async (req, res) => {
  console.log('Received POST request at /api/orderdetails');
  const {
    cust_name,
    cust_phno,
    cust_email,
    delivery_address,
    area_pincode,
    order_date,
    exp_date,
    remarks
  } = req.body;

  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute the insert query
    const result = await connection.execute(
      `INSERT INTO orderdetails (cust_name, cust_phno, cust_email, delivery_address, area_pincode, order_date, exp_date, remarks)
       VALUES (:cust_name, :cust_phno, :cust_email, :delivery_address, :area_pincode, TO_DATE(:order_date, 'DD-MM-YYYY'), TO_DATE(:exp_date, 'DD-MM-YYYY'), :remarks)`,
      {
        cust_name,
        cust_phno,
        cust_email,
        delivery_address,
        area_pincode,
        order_date,
        exp_date,
        remarks
      }
    );

    // Commit the transaction
    await connection.commit();
    console.log('Transaction committed successfully');

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send a success response
    res.status(200).json({ message: 'Order details inserted successfully!' });
  } catch (error) {
    console.error('Error:', error);

    // Send an error response
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//==========================================================================
//===========================job details insert===============================
// app.post('/api/insert/jobdetails', async (req, res) => {
//   console.log('Received POST request at /api/jobdetails');
//   const {
//     orderid,
//     names
//   } = req.body;

app.post('/api/insert/jobdetails', async (req, res) => {
  console.log('Received POST request at /api/jobdetails');
  const {
    orderid,
    product_name,slno,unit_price,qnty
  } = req.body;

  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute the insert query
    // const result = await connection.execute(
    //   `INSERT INTO sample45 (orderid, names) VALUES (:orderid, :names)`,
    //   {
    //     orderid,
    //     names,
    //   }
    // );
    const result = await connection.execute(
      `INSERT INTO jobdetails (orderid, product_name, slno, unit_price, qnty ) VALUES (:orderid, :product_name, :slno, :unit_price, :qnty)`,
      {
        orderid, product_name, slno, unit_price, qnty
      }
    );

    // Commit the transaction
    await connection.commit();
    console.log('Transaction committed successfully');

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send a success response
    res.status(200).json({ message: 'job details inserted successfully!' });
  } catch (error) {
    console.error('Error:', error);

    // Send an error response
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//===============================BILL INSERTION(invoice)==============================
app.post('/api/insert/invoicedetails', async (req, res) => {
  console.log('Received POST request at /api/jobdetails');
  const {
    orderid,delivery_charge,discount_percent,net_sum
  } = req.body;

  try {
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    const result = await connection.execute(
      `INSERT INTO invoicedetails (orderid, invoice_date, delivery_charge, discount_percent, total ) VALUES (:orderid, SYSDATE, :delivery_charge, :discount_percent, ((:net_sum - (:net_sum * :discount_percent/100)) + :delivery_charge))`,
      {
        orderid,delivery_charge,discount_percent,net_sum
      }
    );

    // Commit the transaction
    await connection.commit();
    console.log('Transaction committed successfully');

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send a success response
    res.status(200).json({ message: 'invoice details inserted successfully!' });
  } catch (error) {
    console.error('Error:', error);

    // Send an error response
    res.status(500).json({ error: 'Internal Server Error' });
  }
});


// ---------------------LOGIN API------------------------------------------------------
app.post('/api/loginadmin', async (req, res) => {
  const { username, password } = req.body;

  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute a query to check if the username and password match
    const result = await connection.execute(
      `SELECT * FROM sample23 WHERE uname = :username AND pwd = :password`,
      {
        username,
        password
      }
    );

    // If the query returns a row, authentication is successful
    if (result.rows.length > 0) {
      res.status(200).json({ message: 'Authentication successful!' });
    } else {
      // No matching user found, authentication failed
      res.status(401).json({ error: 'Invalid username or password' });
    }

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//---------------------LOGIN API ENDS--------------------------------------------------------------

//---------------------SELECT * API------------------------------------------------------------------
// Endpoint to fetch delivery details from the database
app.get('/api/deliverydetail', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `SELECT * FROM orderdetails order by order_status desc`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//==================================================================

//-----------------------------product details-----------------------------------
app.get('/jobdetails/:orderid', async (req, res) => {
  const orderId = req.params.orderid;

  try {
    // Get a connection from the pool
    const connection = await oracledb.getConnection(dbConfig);

    // Execute the query
    const result = await connection.execute(
      'SELECT jobid, product_name, qnty, unit_price, net_price FROM jobdetails WHERE orderid = :orderId',
      [orderId],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length > 0) {
      res.status(200).json(result.rows);
    } else {
      res.status(404).send('Job details not found');
    }

    // Release the connection
    await connection.close();
  } catch (error) {
    console.error(error);
    res.status(500).send('Error fetching job details');
  }
});
//=================================================
//======================orderid using email====================
//======================orderid using email====================
app.get('/orderid/email/:cust_email', async (req, res) => {
  const cust_email = req.params.cust_email; // Corrected parameter name

  try {
    // Get a connection from the pool
    const connection = await oracledb.getConnection(dbConfig);

    // Execute the query
    const result = await connection.execute(
      'SELECT orderid FROM orderdetails WHERE cust_email = :cust_email',
      [cust_email], // Use correct parameter name
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length > 0) {
      res.status(200).json(result.rows);
    } else {
      res.status(404).send('Job details not found');
    }

    // Release the connection
    await connection.close();
  } catch (error) {
    console.error(error);
    res.status(500).send('Error fetching job details');
  }
});

//====================all jobs========================
app.get('/api/deliverydetails', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `SELECT orderid, cust_name, cust_email, cust_phno, delivery_address, area_pincode, TO_CHAR(order_date, 'YYYY-MM-DD') AS order_date, TO_CHAR(exp_date, 'YYYY-MM-DD') AS exp_date, remarks, order_status FROM orderdetails order by order_status`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=================product ready for ===================
app.get('/api/productready', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `SELECT orderdetails.orderid,TO_CHAR(orderdetails.exp_date, 'DD-MM-YYYY') AS exp_date, invoicedetails.total,invoicedetails.invoiceid FROM invoicedetails INNER JOIN orderdetails ON invoicedetails.orderid = orderdetails.orderid WHERE orderdetails.order_status = 'ORDER READY'`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=================same order details===================
app.get('/printdetails/:orderid', async (req, res) => {
  const orderId = req.params.orderid;

  try {
    // Get a connection from the pool
    const connection = await oracledb.getConnection(dbConfig);

    // Execute the query
    const result = await connection.execute(
      `SELECT orderdetails.orderid,orderdetails.order_status,TO_CHAR(orderdetails.order_date, 'DD-MM-YYYY') AS order_date,TO_CHAR(orderdetails.exp_date, 'DD-MM-YYYY') AS exp_date,orderdetails.cust_name,orderdetails.cust_email,orderdetails.cust_phno,orderdetails.delivery_address,orderdetails.area_pincode,invoicedetails.total FROM orderdetails INNER JOIN invoicedetails ON invoicedetails.orderid = orderdetails.orderid WHERE orderdetails.orderid = :orderId`,
      [orderId],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length > 0) {
      res.status(200).json(result.rows);
    } else {
      res.status(404).send('Job details not found');
    }

    // Release the connection
    await connection.close();
  } catch (error) {
    console.error(error);
    res.status(500).send('Error fetching job details');
  }
});
//=======================================order details===================
app.get('/orderdetails/:orderid', async (req, res) => {
  const orderId = req.params.orderid;

  try {
    // Get a connection from the pool
    const connection = await oracledb.getConnection(dbConfig);

    // Execute the query
    const result = await connection.execute(
      `SELECT orderid,order_status,TO_CHAR(order_date, 'DD-MM-YYYY') AS order_date,TO_CHAR(exp_date, 'DD-MM-YYYY') AS exp_date,cust_name,cust_email,cust_phno,delivery_address,area_pincode,remarks FROM orderdetails WHERE orderid = :orderId`,
      [orderId],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length > 0) {
      res.status(200).json(result.rows);
    } else {
      res.status(404).send('order details not found');
    }

    // Release the connection
    await connection.close();
  } catch (error) {
    console.error(error);
    res.status(500).send('Error fetching job details');
  }
});
//======================PRINT DETAILS FOR ALL JOBS========================
app.get('/printdetails/notincludebill/:orderid', async (req, res) => {
  const orderId = req.params.orderid;

  try {
    // Get a connection from the pool
    const connection = await oracledb.getConnection(dbConfig);

    // Execute the query
    const result = await connection.execute(
      `SELECT orderdetails.orderid,orderdetails.order_status,TO_CHAR(orderdetails.order_date, 'DD-MM-YYYY') AS order_date,TO_CHAR(orderdetails.exp_date, 'DD-MM-YYYY') AS exp_date,orderdetails.cust_name,orderdetails.cust_email,orderdetails.cust_phno,orderdetails.delivery_address,orderdetails.area_pincode FROM orderdetails WHERE orderdetails.orderid = :orderId`,
      [orderId],
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length > 0) {
      res.status(200).json(result.rows);
    } else {
      res.status(404).send('Job details not found');
    }

    // Release the connection
    await connection.close();
  } catch (error) {
    console.error(error);
    res.status(500).send('Error fetching job details');
  }
});

//========================================================================

//==================product table check for submition==============================
app.get('/submitbutton/orderid/:orderid', async (req, res) => {
  const orderid = req.params.orderid; // Correct parameter name

  try {
    const connection = await oracledb.getConnection(dbConfig);

    const result = await connection.execute(
      'SELECT jobid FROM jobdetails WHERE orderid = :orderid',
      [orderid], // Use correct parameter name
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length > 0) {
      res.status(200).json({ message: 'FOUND RECORDS...CAN EXITED!' });
    } else {
      res.status(404).json({ message: 'NOT FOUND..NEEDED DELETION' });
    }

    await connection.close();
  } catch (error) {
    console.error(error);
    res.status(500).send('Error fetching job details');
  }
});
//=====================SUM(NETPRICE) FOR BILL===========================
app.get('/jobdetails/netsum/:orderid', async (req, res) => {
  const orderid = req.params.orderid; // Corrected parameter name

  try {
    // Get a connection from the pool
    const connection = await oracledb.getConnection(dbConfig);

    // Execute the query
    const result = await connection.execute(
      'select sum(net_price) from jobdetails where orderid = :orderid',
      [orderid], // Use correct parameter name
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length > 0) {
      res.status(200).json(result.rows);
    } else {
      res.status(404).send('sum not found');
    }

    // Release the connection
    await connection.close();
  } catch (error) {
    console.error(error);
    res.status(500).send('Error fetching job details');
  }
});

//===================invoice not created details==============================
app.get('/api/invoice/not/created', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `SELECT DISTINCT o.orderid FROM orderdetails o INNER JOIN jobdetails j ON o.orderid = j.orderid LEFT JOIN invoicedetails i ON o.orderid = i.orderid WHERE i.orderid IS NULL`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=====================================================
//=================invoice ready=======================
app.get('/api/invoiceready', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
     // `select invoiceid,orderid,invoice_date,delivery_charge,discount_percent,total from invoicedetails`
     `SELECT invoiceid, orderid, TO_CHAR(invoice_date, 'DD-MM-YYYY') as invoice_date, total FROM invoicedetails`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=====================================================
//=====================CONTRACTOR LOGIN=============================

app.post('/api/logincontractor', async (req, res) => {
  const { username, password } = req.body;

  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute a query to check if the username and password match
    const result = await connection.execute(
      `SELECT * FROM contractordetails WHERE cntr_email = :username AND pswd = :password`,
      {
        username,
        password
      }
    );

    // If the query returns a row, authentication is successful
    if (result.rows.length > 0) {
      // Insert cntr_id into contractorsession table
       await connection.execute(
        `INSERT INTO contractorsession (id) SELECT cntr_id FROM contractordetails WHERE cntr_email = :username`,
        { username: username } // Explicitly bind the username parameter
      )
      await connection.commit();
    console.log('Transaction committed successfully');




      res.status(200).json({ message: 'Authentication successful!' });
    } else {
      // No matching user found, authentication failed
      res.status(401).json({ error: 'Invalid username or password' });
    }

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

//==================================================================
//=====================CONTRACTOR DETAILS INSERT================================

const nodemailer = require('nodemailer');

// Create a transporter object using SMTP
let transporter = nodemailer.createTransport({
    service: 'Gmail', // Or use any other SMTP service provider
    auth: {
        user: 'dellihurry@gmail.com',
        pass: 'rsxf tqey ifiv fbei'
    }
});

// Modify the route handler for inserting contractor details
app.post('/api/insert/cntrdetails', async (req, res) => {
    console.log('Received POST request at /api/insert/cntrdetails');
    const {
        cntr_fname,
        cntr_lname,
        cntr_email,
        cntr_phno,
        local_address,
        company_name,
        pswd
    } = req.body;

    try {
        // Connect to Oracle Database
        const connection = await oracledb.getConnection(dbConfig);
        console.log('Connected to Oracle Database');

        // Execute the insert query
        const result = await connection.execute(
            `INSERT INTO contractordetails (cntr_fname, cntr_lname, cntr_email, cntr_phno, local_address, company_name, pswd)
             VALUES (:cntr_fname, :cntr_lname, :cntr_email, :cntr_phno, :local_address, :company_name, :pswd)`,
            {
                cntr_fname,
                cntr_lname,
                cntr_email,
                cntr_phno,
                local_address,
                company_name,
                pswd
            }
        );

        // Commit the transaction
        await connection.commit();
        console.log('Transaction committed successfully');

        // Release the connection
        await connection.close();
        console.log('Connection closed successfully');

        // Send welcome email with login credentials
        let mailOptions = {
            from: 'dellihurry@gmail.com',
            to: cntr_email, // Sending email to the provided email address
            subject: 'Welcome to DelliHurry - Login Credentials',
            text: `Welcome to DelliHurry!\n\nYour login credentials are as follows:\nUsername: ${cntr_email}\nPassword: ${pswd}`
        };

        transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
                console.error('Error sending email:', error);
                // Send an error response
                res.status(500).json({ error: 'Internal Server Error' });
            } else {
                console.log('Email sent:', info.response);
                // Send a success response
                res.status(200).json({ message: 'Contractor details inserted successfully!' });
            }
        });

    } catch (error) {
        console.error('Error:', error);
        // Send an error response
        res.status(500).json({ error: 'Internal Server Error' });
    }
});


//=====================CONTRACTOR DETAILS INSERT --end==========================
//=====================empty check in contractor details in admin panel =========================
app.get('/api/contractor/emptycheck', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `select cntr_id,cntr_fname,cntr_lname,cntr_email,cntr_phno,local_address,company_name,pswd from contractordetails`
    );

    // If the query returns a row, authentication is successful
    if (result.rows.length > 0) {
      //res.status(200).json({ message: 'New Page!' });
      res.status(200).json(result.rows);
    } else {
      // No matching user found, authentication failed
      res.status(401).json({ error: 'Empty Page' });
    }

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=====================pincode insertion=========================================
app.post('/api/insert/areadetails', async (req, res) => {
  console.log('Received POST request at /api/jobdetails');
  const {
    pincode,area,local_place
  } = req.body;

  try {
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    const result = await connection.execute(
      `INSERT INTO areadetails (pincode, area, local_place) VALUES (:pincode,:area,:local_place)`,
      {
        pincode,area,local_place
      }
    );

    // Commit the transaction
    await connection.commit();
    console.log('Transaction committed successfully');

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send a success response
    res.status(200).json({ message: 'area details inserted successfully!' });
  } catch (error) {
    console.error('Error:', error);

    // Send an error response
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=====================pincode insertion  --end==================================
app.get('/api/pincode/display', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `select pincode,area,local_place from areadetails order by area`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=====================empty check in contractor details --end===================
//=====================splash screen check=======================================
app.get('/api/login/session/contractorpanel', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `select id from contractorsession`
    );

    // If the query returns a row, authentication is successful
    if (result.rows.length > 0) {
      //res.status(200).json({ message: 'New Page!' });
      res.status(200).json(result.rows);
    } else {
      // No matching user found, authentication failed
      res.status(401).json({ error: 'Empty Page' });
    }

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//===============================================================================
//--------------------pincode checking on order details creation site------------------
app.post('/api/pincheck/fordelivery', async (req, res) => {
  const {area_pincode} = req.body;

  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute a query to check if the username and password match
    const result = await connection.execute(
      `select pincode from areadetails where pincode=:area_pincode`,
      [area_pincode]
    );

    // If the query returns a row, authentication is successful
    if (result.rows.length > 0) {
      // Insert cntr_id into contractorsession 
      res.status(200).json({ message: 'proceed to okey!' });
    } else {
      // No matching user found, authentication failed
      res.status(401).json({ error: 'Invalid username or password' });
    }

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=====================================================================================
//======================select id from contractorsession==========================
app.get('/api/contractorid/select', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `select id from contractorsession`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//================================================================================
//========================count of rows in product ready============================
app.get('/api/countforloop/select', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `SELECT count(invoicedetails.orderid) FROM invoicedetails INNER JOIN orderdetails ON invoicedetails.orderid = orderdetails.orderid WHERE orderdetails.order_status = 'ORDER READY'`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//==================================================================================
//======================delete order from jobcreation=================================
app.post('/api/delete/forcefulback', async (req, res) => {
  const {cust_email} = req.body;

  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute a query to check if the username and password match
    const result = await connection.execute(
      `delete from orderdetails where cust_email=:cust_email`,
      [cust_email]
    );
    // Commit the transaction
    await connection.commit();
    console.log('Transaction committed successfully');

    // If the query returns a row, authentication is successful

    if (result.rowsAffected && result.rowsAffected > 0) {
      res.status(200).json({ message: 'Order details deleted!' });
    } else {
      // No matching order found
      res.status(404).json({ error: 'Order not found' });
    }
    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=====================================================================================
//=============================INSERT TO DELIVERY DETAILS==============================
app.post('/api/insert/DELIVERYdetails', async (req, res) => {
  console.log('Received POST request at /api/insert/DELIVERYdetails');
  const {
    invoiceid,orderid,cntrid
  } = req.body;

  try {
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    const result = await connection.execute(
      // `INSERT INTO areadetails (pincode, area, local_place) VALUES (:pincode,:area,:local_place)`,
      `INSERT INTO deliverydetails (invoiceid, orderid, cntrid) 
      VALUES (:invoiceid, :orderid, :cntrid)`,
      {
        invoiceid,orderid,cntrid
      }
    );

    // Commit the transaction
    await connection.commit();
    console.log('Transaction committed successfully');

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send a success response
    res.status(200).json({ message: 'delivery details inserted successfully!' });
  } catch (error) {
    console.error('Error:', error);

    // Send an error response
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=====================================================================================
//==================================assigmnent sheet adminpanel========================
app.get('/api/foradmin/assignmentsheet', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `select deliverydetails.deliveryid,deliverydetails.orderid,deliverydetails.cntrid,TO_CHAR(orderdetails.exp_date, 'DD-MM-YYYY') as exp_date,deliverydetails.invoiceid from orderdetails inner join deliverydetails on deliverydetails.orderid = orderdetails.orderid where deliverydetails.delivery_status='New' order by deliverydetails.orderid`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
    //res.status(200).json({ status: 'Delivery details Fetched' });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//======================================driver id from orderid========================
app.get('/delivery/assignment/:orderid', async (req, res) => {
  const orderid = req.params.orderid; // Corrected parameter name

  try {
    // Get a connection from the pool
    const connection = await oracledb.getConnection(dbConfig);

    // Execute the query
    const result = await connection.execute(
      'select driverid,drvr_name,vtype from driverdetails where area in (select area from areadetails where pincode in (select area_pincode from orderdetails where orderid = :orderid))',
      [orderid], // Use correct parameter name
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length > 0) {
      res.status(200).json(result.rows);
    } else {
      res.status(404).send('driver details not found');
    }

    // Release the connection
    await connection.close();
  } catch (error) {
    console.error(error);
    res.status(500).send('Error fetching job details');
  }
});
//=====================assignment details to assignment table=========================
app.post('/api/insert/assignmentdetailsfor/driver', async (req, res) => {
  console.log('Received POST request at /api/insert/assignmentdetails');
  const {
    driverid, deliveryid, orderid, invoiceid
  } = req.body;

  let connection; // Declare connection variable outside the try-catch block

  try {
    // Connect to Oracle Database
    connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute the insert query
    await connection.execute(
      `insert into assignmentdetails (driverid, deliveryid, orderid, invoiceid) values (:driverid, :deliveryid, :orderid, :invoiceid)`,
      {
        driverid, deliveryid, orderid, invoiceid
      }
    );
    await connection.commit();
    console.log('Transaction committed successfully');

    // Update deliverydetails table
    const result = await connection.execute(
      `update deliverydetails set delivery_status = 'ASSIGNED' where deliveryid = :deliveryid`,
      [deliveryid]
    );

    // Commit the transaction
    await connection.commit();
    console.log('Transaction committed successfully');

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Check if any rows were affected by the update
    const rowsAffected = result.rowsAffected;
    if (rowsAffected && rowsAffected > 0) {
      // Send a success response if update was successful
      res.status(200).json({ message: 'Assignment details inserted and delivery status updated successfully!' });
    } else {
      // Send a failure response if no rows were updated
      res.status(404).json({ error: 'No matching deliveryid found for update' });
    }

  } catch (error) {
    console.error('Error:', error);

    // Rollback transaction if there's an error
    if (connection) {
      try {
        await connection.rollback();
        console.log('Rollback successful');
      } catch (rollbackError) {
        console.error('Rollback error:', rollbackError);
      }
    }

    // Send an error response
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

//========================marked page display========================================
app.get('/api/foradmin/markedpage/temp', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `select assignmentdetails.asmtid,assignmentdetails.driverid,assignmentdetails.deliveryid,assignmentdetails.orderid,assignmentdetails.invoiceid,driverdetails.area from assignmentdetails inner join driverdetails on assignmentdetails.driverid=driverdetails.driverid where assignmentdetails.viewstatus='FALSE' AND assignmentdetails.asmtstatus='NEW' order by area`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
    //res.status(200).json({ status: 'Delivery details Fetched' });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

//====================================================================================
//---------------------------------ASSIGNED PAGE DISPLAY------------------------------
app.get('/api/foradmin/ASSIGNEDpage/temp', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `select assignmentdetails.asmtid,assignmentdetails.driverid,assignmentdetails.deliveryid,assignmentdetails.orderid,assignmentdetails.invoiceid,driverdetails.area from assignmentdetails inner join driverdetails on assignmentdetails.driverid=driverdetails.driverid where assignmentdetails.viewstatus='TRUE' AND assignmentdetails.asmtstatus='NEW' order by area`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
    //res.status(200).json({ status: 'Delivery details Fetched' });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

//------------------------------------------------------------------------------------
//=================================delete from marked=================================
// Update delivery status endpoint
app.put('/api/update-delivery/foradmin', async (req, res) => {
  const { deliveryId } = req.body;
  let connection; 
  try {
    // Acquire a connection from the pool
    const connection = await oracledb.getConnection(dbConfig);

    // Start a transaction
   // await connection.execute('BEGIN');

    // Run the update query
    await connection.execute(
      `UPDATE deliverydetails SET delivery_status = 'New' WHERE deliveryid = :deliveryId`,
      { deliveryId }
    );

    // Run the delete query
    await connection.execute(
      `DELETE FROM assignmentdetails WHERE deliveryid = :deliveryId`,
      { deliveryId }
    );

    // Commit the transaction
    await connection.execute('COMMIT');

    // Release the connection
    await connection.close();

    res.status(200).json({ message: 'Delivery status updated and assignment details deleted successfully' });
  } catch (error) {
    console.error('Error updating delivery status:', error);
    
    // Rollback the transaction if an error occurs
    await connection.execute('ROLLBACK');

    res.status(500).json({ error: 'Failed to update delivery status and delete assignment details' });
  }
});
//============================otp verification table creation========================================================
app.post('/api/insert/otpdetails1', async (req, res) => {
  console.log('Received POST request at /api/insert/otpdetails');
  const {
      email,
      otps
  } = req.body;

  try {
      const connection = await oracledb.getConnection(dbConfig);
      console.log('Connected to Oracle Database');

      const result = await connection.execute(
          `insert into otpdetails(email,otps) values (:email,:otps)`,
          {
              email,
              otps
          }
      );

      // Commit the transaction
      await connection.commit();
      console.log('Transaction committed successfully');

      // Release the connection
      await connection.close();
      console.log('Connection closed successfully');

      // Send email verification
      let mailOptions = {
          from: 'dellihurry@gmail.com',
          to: email,
          subject: 'Email Verification',
          text: `Your OTP for email verification is: ${otps}`
      };

      transporter.sendMail(mailOptions, (error, info) => {
          if (error) {
              console.error('Error sending email:', error);
              // Send an error response
              res.status(500).json({ error: 'Internal Server Error' });
          } else {
              console.log('Email sent:', info.response);
              // Send a success response
              res.status(200).json({ message: 'OTP details inserted successfully and email sent!' });
          }
      });

  } catch (error) {
      console.error('Error:', error);
      // Send an error response
      res.status(500).json({ error: 'Internal Server Error' });
  }
});

//==================================driver details insert=============================
app.post('/api/insert/driverdetails-otp', async (req, res) => {
  console.log('Received POST request at /api/insert/driverdetails-otp');
  const {
    drvr_name,drvr_phno,drvr_email,area,vno,vtype,pswd
  } = req.body;

  try {
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    const result = await connection.execute(
      // `INSERT INTO areadetails (pincode, area, local_place) VALUES (:pincode,:area,:local_place)`,
      `insert into driverdetails (drvr_name,drvr_phno,drvr_email,area,vno,vtype,pswd) values (:drvr_name,:drvr_phno,:drvr_email,:area,:vno,:vtype,:pswd)`,
      {
        drvr_name,drvr_phno,drvr_email,area,vno,vtype,pswd
      }
    );

    // Commit the transaction
    await connection.commit();
    console.log('Transaction committed successfully');

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send a success response
    res.status(200).json({ message: 'driver details inserted successfully!' });
  } catch (error) {
    console.error('Error:', error);

    // Send an error response
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//====================================================================================
//================================verify and insert===================================
app.post('/api/registerdriver/verify-otp', async (req, res) => {
  const { drvr_name,drvr_phno,email,area,vno,vtype,pswd,otps } = req.body;

  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute a query to check if the username and password match
    const result = await connection.execute(
      `select * from otpdetails where email=:email and otps=:otps`,
      {
        email,otps
      }
    );

    // If the query returns a row, authentication is successful
    if (result.rows.length > 0) {
      // Insert cntr_id into contractorsession table
       await connection.execute(
        `insert into driverdetails (drvr_name,drvr_phno,drvr_email,area,vno,vtype,pswd) values (:drvr_name,:drvr_phno,:email,:area,:vno,:vtype,:pswd)`,
        { drvr_name,drvr_phno,email,area,vno,vtype,pswd} // Explicitly bind the username parameter
      )
      await connection.commit();
    console.log('Transaction committed successfully');




      res.status(200).json({ message: 'Authentication successful!' });
    } else {
      // No matching user found, authentication failed
      res.status(401).json({ error: 'Invalid username or password' });
    }

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

//====================================================================================
//=====================DRIVER LOGIN=============================

app.post('/api/logindriver', async (req, res) => {
  const { username, password } = req.body;

  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute a query to check if the username and password match
    const result = await connection.execute(
      `SELECT * FROM driverdetails WHERE drvr_email = :username AND pswd = :password`,
      {
        username,
        password
      }
    );

    // If the query returns a row, authentication is successful
    if (result.rows.length > 0) {
      // Insert cntr_id into contractorsession table
       await connection.execute(
        `INSERT INTO contractorsession (id) SELECT driverid FROM driverdetails WHERE drvr_email = :username`,
        { username: username } // Explicitly bind the username parameter
      )
      await connection.commit();
    console.log('Transaction committed successfully');

      res.status(200).json({ message: 'Authentication successful!' });
    } else {
      // No matching user found, authentication failed
      res.status(401).json({ error: 'Invalid username or password' });
    }

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//========================USER DETECT===============================
app.get('/api/user-check', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `select ID from contractorsession where id like 'CNTR%'`
    );

    // If the query returns a row, authentication is successful
    if (result.rows.length > 0) {
      //res.status(200).json({ message: 'New Page!' });
      res.status(200).json(result.rows);
    } else {
      // No matching user found, authentication failed
      res.status(401).json({ error: 'May Be Driver' });
    }

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

//==================================================================
//==================================FALSE -> TRUE===================
app.put('/api/update-assignment-details/final', async (req, res) => {
  try {
    // Establish a connection to the Oracle database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute the SQL update statement
    const result = await connection.execute(
      `UPDATE assignmentdetails SET viewstatus = 'TRUE' WHERE viewstatus = 'FALSE'`
    );

    await connection.commit();
    console.log('Committed :)');

    // Release the connection
    await connection.close();

    // Respond with success message
    res.status(200).json({ message: 'Records updated successfully' });
  } catch (error) {
    console.error('Error updating records:', error);
    res.status(500).json({ error: 'Internal server error :(' });
  }
});
//==================================================================
//==========================log out=================================
// Delete endpoint for contractorsession table
app.delete('/contractorsession/logout', async (req, res) => {
  //const id = req.params.id;
  
  try {
    // Create a connection pool
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');
    
    // Execute the delete query
    const result = await connection.execute(
      `delete from contractorsession`,
// Commit the transaction automatically
    );
    await connection.commit();
    console.log('Committed :)');

    // Release the connection
    await connection.close();

    // Check if any rows were affected
    if (result.rowsAffected && result.rowsAffected >0) {
      res.status(200).send(`Contractor session deleted successfully.`);
    } else {
      res.status(404).send(`Contractor session not deleted `);
    }
  } catch (error) {
    console.error('Error deleting contractor session:', error);
    res.status(500).send('Internal server error.');
  }
});
//=======================driver assigned details True============================


//==================================================================
//===================horizontal tile===============================

app.put('/update-status-to-pickup/:orderid', async (req, res) => {
  const orderid = req.params.orderid; // Corrected parameter name

  try {
    // Get a connection from the pool
    const connection = await oracledb.getConnection(dbConfig);

    // Execute the query
    const result = await connection.execute(
      `update assignmentdetails set asmtstatus='PICKUP' WHERE orderid=:orderid`,
      [orderid], // Use correct parameter name
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );
  await connection.commit();
   console.log('Committed :)');

    // Release the connection
   await connection.close();

   // Respond with success message
     res.status(200).json({ message: 'updated to pickup successfully' });
   } catch (error) {
    console.error('Error updating records:', error);
     res.status(500).json({ error: 'Internal server error :(' });
   }
 });
 //==============driverViewNewRequest=================================
 app.get('/driverViewNewRequest', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `select deliveryid,orderid,invoiceid from assignmentdetails where viewstatus='TRUE' and asmtstatus='NEW' AND driverid in (select id from contractorsession) order by deliveryid`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
    //res.status(200).json({ status: 'Delivery details Fetched' });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

//==================================================================
//======================driverViewPickUp===========================
app.get('/driverViewPickUp', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `select deliveryid,orderid,invoiceid from assignmentdetails where viewstatus='TRUE' and asmtstatus='PICKUP' AND driverid in (select id from contractorsession) order by deliveryid`
    );

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');

    // Send the fetched data as response
    res.status(200).json(result.rows);
    //res.status(200).json({ status: 'Delivery details Fetched' });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//====================pickup otp SEND============================
app.post('/api/insert/otpdetails2', async (req, res) => {
  console.log('Received POST request at /api/insert/otpdetails2');
  const {
      email,
      otps
  } = req.body;

  try {
      const connection = await oracledb.getConnection(dbConfig);
      console.log('Connected to Oracle Database');

      const result = await connection.execute(
          `insert into otpdetails(email,otps) values (:email,:otps)`,
          {
              email,
              otps
          }
      );

      // Commit the transaction
      await connection.commit();
      console.log('Transaction committed successfully');

      // Release the connection
      await connection.close();
      console.log('Connection closed successfully');

      // Send email verification
      let mailOptions = {
          from: 'dellihurry@gmail.com',
          to: email,
          subject: 'Pick Up Verification',
          text: `Share OTP to Transporter, if loading complete=>OTP: ${otps}`
      };

      transporter.sendMail(mailOptions, (error, info) => {
          if (error) {
              console.error('Error sending email:', error);
              // Send an error response
              res.status(500).json({ error: 'Internal Server Error' });
          } else {
              console.log('Email sent:', info.response);
              // Send a success response
              res.status(200).json({ message: 'OTP details inserted successfully and email sent!' });
          }
      });

  } catch (error) {
      console.error('Error:', error);
      // Send an error response
      res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=========================pickup verification=======================
app.post('/api/pickup-verification/verify-otp', async (req, res) => {
  const { email,otps } = req.body;

  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute a query to check if the username and password match
    const result = await connection.execute(
      `select * from otpdetails where email=:email and otps=:otps`,
      {
        email,otps
      }
    );

    // If the query returns a row, authentication is successful
    if (result.rows.length > 0) {
      await connection.execute(
        `update assignmentdetails set asmtstatus='DELIVERY' where viewstatus='TRUE' and asmtstatus='PICKUP' AND driverid in (select id from contractorsession)`,
        // {
        //   email,otps
        // }
      );
      // Commit the transaction
      await connection.commit();
      console.log('Transaction committed successfully');
      // Insert cntr_id into contractorsession table
      res.status(200).json({ message: 'Authentication successful!' });
    } else {
      // No matching user found, authentication failed
      res.status(401).json({ error: 'Invalid username or password' });
    }

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//=======================ViewDelivery===================================
app.get('/driverViewDelivery', async (req, res) => {
  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Query to fetch delivery details
    const result = await connection.execute(
      `select deliveryid,orderid,invoiceid from assignmentdetails where viewstatus='TRUE' and asmtstatus='DELIVERY' AND driverid in (select id from contractorsession) order by deliveryid`
    );

   
    // Send the fetched data as response
    res.status(200).json(result.rows);
    //res.status(200).json({ status: 'Delivery details Fetched' });
     // Release the connection
     await connection.close();
     console.log('Connection closed successfully');
 
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//======================delivery verification========================

//==================customer email=================================
app.get('/cust-email/deliveryverification/:orderid', async (req, res) => {
  const orderid = req.params.orderid; // Corrected parameter name

  try {
    // Get a connection from the pool
    const connection = await oracledb.getConnection(dbConfig);

    // Execute the query
    const result = await connection.execute(
      `select cust_email from orderdetails where orderid=:orderid`,
      [orderid], // Use correct parameter name
      { outFormat: oracledb.OUT_FORMAT_OBJECT }
    );

    if (result.rows.length > 0) {
      res.status(200).json(result.rows);
    } else {
      res.status(404).send('email not found');
    }

    // Release the connection
    await connection.close();
  } catch (error) {
    console.error(error);
    res.status(500).send('Error fetching job details');
  }
});
//=========================delivery otp insertion===================
app.post('/api/insert/otpdetails3', async (req, res) => {
  console.log('Received POST request at /api/insert/otpdetails3');
  const {
      email,
      otps
  } = req.body;

  try {
      const connection = await oracledb.getConnection(dbConfig);
      console.log('Connected to Oracle Database');

      const result = await connection.execute(
          `insert into otpdetails(email,otps) values (:email,:otps)`,
          {
              email,
              otps
          }
      );

      // Commit the transaction
      await connection.commit();
      console.log('Transaction committed successfully');

      // Release the connection
      await connection.close();
      console.log('Connection closed successfully');

      // Send email verification
      let mailOptions = {
          from: 'dellihurry@gmail.com',
          to: email,
          cc: 'mrgroove26@gmail.com',
          subject: 'Delivery Confirmation',
          text: `Share OTP to Transporter, if Package accepted complete=>OTP: ${otps}`
      };

      transporter.sendMail(mailOptions, (error, info) => {
          if (error) {
              console.error('Error sending email:', error);
              // Send an error response
              res.status(500).json({ error: 'Internal Server Error' });
          } else {
              console.log('Email sent:', info.response);
              // Send a success response
              res.status(200).json({ message: 'OTP details inserted successfully and email sent!' });
          }
      });

  } catch (error) {
      console.error('Error:', error);
      // Send an error response
      res.status(500).json({ error: 'Internal Server Error' });
  }
});


//===================================================================
//========================delivery confirmation======================
app.post('/api/delivery-confirmation/verify-otp', async (req, res) => {
  const { email,otps,invoiceId,deliveryId,orderId } = req.body;

  try {
    // Connect to Oracle Database
    const connection = await oracledb.getConnection(dbConfig);
    console.log('Connected to Oracle Database');

    // Execute a query to check if the username and password match
    const result = await connection.execute(
      `select * from otpdetails where email=:email and otps=:otps`,
      {
        email,otps
      }
    );

    // If the query returns a row, authentication is successful
    if (result.rows.length > 0) {
      await connection.execute(
        `update assignmentdetails set asmtstatus='COMPLETED' where viewstatus='TRUE' and asmtstatus='DELIVERY' AND deliveryid=:deliveryId`,
        {
          deliveryId
        }
      );
      // Commit the transaction
      await connection.commit();
      console.log('Transaction committed successfully');
      await connection.execute(
        `update deliverydetails set delivery_status='COMPLETED' where deliveryid=:deliveryId`,
        {
          deliveryId
        }
      );
      // Commit the transaction
      await connection.commit();
      console.log('Transaction committed successfully');
      await connection.execute(
        `update orderdetails set order_status='DELIVERED' where orderid=:orderId`,
        {
          orderId
        }
      );
      // Commit the transaction
      await connection.commit();
      console.log('Transaction committed successfully');
      // Insert cntr_id into contractorsession table
      res.status(200).json({ message: 'Authentication successful!' });
    } else {
      // No matching user found, authentication failed
      res.status(401).json({ error: 'Invalid username or password' });
    }

    // Release the connection
    await connection.close();
    console.log('Connection closed successfully');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
//===================================================================

//Start the server
app.listen(port, '192.168.43.156', () => {
  console.log(`Server is running at http://192.168.43.156:${port}`);
});
// app.listen(port, '192.168.43.156', () => {
//   console.log(`Server is running at http://192.168.1.123:${port}`);
// });
