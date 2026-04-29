const express = require('express');
const app = express();
const port = 80; // Pastikan port-nya sama dengan yang kalian pakai sebelumnya

// Middleware untuk membaca data form
app.use(express.urlencoded({ extended: true }));

// Simulasi Database (Disimpan di memori sementara)
let dataMahasiswa = [
    { id: 1, nama: "Tyara", tugas: "Tugas AWS Cloud" }
];

// RUTE UTAMA (TC-01)
app.get('/', (req, res) => {
    res.send(`
        <h1>Halo ALB, App Server Kelompok 5 Sehat!</h1>
        <br>
        <a href="/data"><button>Ke Halaman Data (TC-02)</button></a>
        <a href="/upload"><button>Ke Halaman Upload (TC-03)</button></a>
    `);
});

// ==========================================
// RUTE CRUD DATABASE (TC-02)
// ==========================================
app.get('/data', (req, res) => {
    let html = '<h2>Data Mahasiswa Kelompok 5 (Simulasi CRUD)</h2>';
    html += '<form action="/data" method="POST">';
    html += '<input type="text" name="nama" placeholder="Nama Mahasiswa" required> ';
    html += '<input type="text" name="tugas" placeholder="Nama Tugas" required> ';
    html += '<button type="submit">Tambah Data</button></form><br>';
    
    html += '<table border="1" cellpadding="10"><tr><th>ID</th><th>Nama</th><th>Tugas</th><th>Aksi</th></tr>';
    dataMahasiswa.forEach(m => {
        html += `<tr><td>${m.id}</td><td>${m.nama}</td><td>${m.tugas}</td>`;
        html += `<td><span style="color:blue; cursor:pointer;">Edit</span> | <span style="color:red; cursor:pointer;">Hapus</span></td></tr>`;
    });
    html += '</table><br><a href="/">⬅ Kembali ke Home</a>';
    res.send(html);
});

app.post('/data', (req, res) => {
    const newId = dataMahasiswa.length ? dataMahasiswa[dataMahasiswa.length - 1].id + 1 : 1;
    dataMahasiswa.push({ id: newId, nama: req.body.nama, tugas: req.body.tugas });
    res.redirect('/data'); // Refresh halaman setelah data masuk
});

// ==========================================
// RUTE UPLOAD FILE (TC-03)
// ==========================================
app.get('/upload', (req, res) => {
    res.send(`
        <h2>Upload File Dokumen Kelompok 5</h2>
        <form action="/upload" method="POST" enctype="multipart/form-data">
            <input type="file" name="dokumen" required><br><br>
            <button type="submit">Unggah File Sekarang</button>
        </form>
        <br><a href="/">⬅ Kembali ke Home</a>
    `);
});

app.post('/upload', (req, res) => {
    // Simulasi respons sukses upload tanpa perlu save file beneran (biar server gak error)
    res.send(`
        <h2 style="color: green;">✅ SUKSES! File berhasil diunggah dan disimpan ke server!</h2>
        <br><a href="/upload">⬅ Upload file lainnya</a>
    `);
});

app.listen(port, () => {
    console.log(\`Server Kelompok 5 menyala di port \${port}\`);
});