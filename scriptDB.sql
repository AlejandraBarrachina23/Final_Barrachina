USE [EdicionesElemento]
GO
/****** Object:  Table [dbo].[Autores]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Autores](
	[ID_Autor] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NULL,
 CONSTRAINT [PK_Autores] PRIMARY KEY CLUSTERED 
(
	[ID_Autor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Editoriales]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Editoriales](
	[ID_Editorial] [int] IDENTITY(1,1) NOT NULL,
	[Nombre_Editorial] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Editoriales] PRIMARY KEY CLUSTERED 
(
	[ID_Editorial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Formatos]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Formatos](
	[ID_Formato] [int] IDENTITY(1,1) NOT NULL,
	[Medidas_Formato] [varchar](15) NOT NULL,
 CONSTRAINT [PK_Formatos] PRIMARY KEY CLUSTERED 
(
	[ID_Formato] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Libros]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Libros](
	[ISBN] [varchar](50) NOT NULL,
	[Titulo] [varchar](200) NOT NULL,
	[ID_Formato] [int] NULL,
	[Sinopsis] [text] NULL,
	[Fecha_Edicion] [int] NOT NULL,
	[Precio] [float] NULL,
	[Portada] [varchar](max) NULL,
	[Estado] [bit] NULL,
	[ID_Editorial] [int] NULL,
 CONSTRAINT [PK_libros] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LibrosxAutores]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibrosxAutores](
	[ISBN] [varchar](50) NOT NULL,
	[ID_Autor] [int] NOT NULL,
 CONSTRAINT [PK_LibrosxAutores] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC,
	[ID_Autor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LibrosxEditoriales]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibrosxEditoriales](
	[ISBN] [varchar](50) NOT NULL,
	[ID_Editorial] [int] NOT NULL,
 CONSTRAINT [PK_LibrosxEditoriales] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC,
	[ID_Editorial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Libros] ADD  DEFAULT ((1)) FOR [ID_Formato]
GO
ALTER TABLE [dbo].[Libros] ADD  DEFAULT ('No disponible') FOR [Sinopsis]
GO
ALTER TABLE [dbo].[Libros] ADD  DEFAULT ((0)) FOR [Precio]
GO
ALTER TABLE [dbo].[Libros] ADD  CONSTRAINT [DF_Libros_Portada]  DEFAULT ('~/img/portada/imagen-no-disponible.png') FOR [Portada]
GO
ALTER TABLE [dbo].[Libros] ADD  CONSTRAINT [DF_Libros_Estado]  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[Libros]  WITH CHECK ADD  CONSTRAINT [FK_Libros_Formato] FOREIGN KEY([ID_Formato])
REFERENCES [dbo].[Formatos] ([ID_Formato])
GO
ALTER TABLE [dbo].[Libros] CHECK CONSTRAINT [FK_Libros_Formato]
GO
ALTER TABLE [dbo].[LibrosxAutores]  WITH CHECK ADD FOREIGN KEY([ID_Autor])
REFERENCES [dbo].[Autores] ([ID_Autor])
GO
ALTER TABLE [dbo].[LibrosxAutores]  WITH CHECK ADD FOREIGN KEY([ISBN])
REFERENCES [dbo].[Libros] ([ISBN])
GO
ALTER TABLE [dbo].[LibrosxEditoriales]  WITH CHECK ADD FOREIGN KEY([ID_Editorial])
REFERENCES [dbo].[Editoriales] ([ID_Editorial])
GO
ALTER TABLE [dbo].[LibrosxEditoriales]  WITH CHECK ADD FOREIGN KEY([ISBN])
REFERENCES [dbo].[Libros] ([ISBN])
GO
/****** Object:  StoredProcedure [dbo].[SP_AgregarLibro]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AgregarLibro] @ISBN varchar(50), @Titulo varchar(200),
								 @ID_Formato int, @Sinopsis text,
								 @Fecha_Edicion int, @Portada VARCHAR(MAX), @Editorial int
AS
INSERT INTO Libros(ISBN,Titulo,ID_Formato,Sinopsis,Fecha_Edicion,Portada,ID_Editorial) 
VALUES (@ISBN,@Titulo,@ID_Formato,@Sinopsis,@Fecha_Edicion,@Portada,@Editorial)
GO
/****** Object:  StoredProcedure [dbo].[SP_AgregarLibroxAutor]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AgregarLibroxAutor] @ISBN VARCHAR(50), @Autor int
AS
INSERT INTO LibroxLibrosxAutores(ISBN, ID_Autor) VALUES (@ISBN,@Autor)
GO
/****** Object:  StoredProcedure [dbo].[SP_EliminarLibro]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_EliminarLibro] @ISBN varchar(50)
AS
UPDATE Libros SET Estado = 0 WHERE ISBN = @ISBN;
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarEditoriales]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ListarEditoriales]
AS
SELECT ID_Editorial,Nombre_Editorial FROM Editoriales;
GO
/****** Object:  StoredProcedure [dbo].[SP_ListarLibros]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ListarLibros] 
AS
SELECT Libros.ISBN,Titulo,Sinopsis,Libros.ID_Formato, Libros.ID_Editorial,Nombre_Editorial,Fecha_Edicion, 
Portada,Autores.ID_Autor, Autores.Nombre, Autores.Apellido from Libros 
INNER JOIN LibrosxAutores 
ON LibrosxAutores.ISBN = Libros.ISBN INNER JOIN Autores
ON Autores.ID_Autor = LibrosxAutores.ID_Autor INNER JOIN Formatos
ON Formatos.ID_Formato = Libros.ID_Formato INNER JOIN Editoriales
ON Editoriales.ID_Editorial = Libros.ID_Editorial
WHERE Estado = 1;

GO
/****** Object:  StoredProcedure [dbo].[SP_ModificarLibro]    Script Date: 16/11/2020 10:41:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ModificarLibro] @ISBN varchar(50), @Titulo varchar(200),
								 @ID_Formato int, @Sinopsis text,
								 @Fecha_Edicion int, @Portada varchar(max)
AS
UPDATE Libros SET Titulo = @Titulo, ID_Formato = @ID_Formato,Sinopsis=@Sinopsis,Fecha_Edicion=@Fecha_Edicion,
Portada = @Portada WHERE ISBN = @ISBN;
GO
