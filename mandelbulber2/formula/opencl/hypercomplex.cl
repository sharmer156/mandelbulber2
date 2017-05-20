/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * 3D Mandelbrot formula invented by David Makin
 * @reference
 * http://www.fractalforums.com/3d-fractal-generation/true-3d-mandlebrot-type-fractal/msg7235/#msg7235
 */

/* ### This file has been autogenerated. Remove this line, to prevent override. ### */

#ifndef DOUBLE_PRECISION
inline void HypercomplexIteration(float4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(fractal);

	aux->r_dz = aux->r_dz * 2.0f * aux->r;
	float newx = mad(-z->z, z->z, mad(z->x, z->x, -z->y * z->y)) - z->w * z->w;
	float newy = mad(2.0f * z->x, z->y, -2.0f * z->w * z->z);
	float newz = mad(2.0f * z->x, z->z, -2.0f * z->y * z->w);
	float neww = mad(2.0f * z->x, z->w, -2.0f * z->y * z->z);
	z->x = newx;
	z->y = newy;
	z->z = newz;
	z->w = neww;
}
#else
inline void HypercomplexIteration(double4 *z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	Q_UNUSED(fractal);

	aux->r_dz = aux->r_dz * 2.0 * aux->r;
	double newx = mad(-z->z, z->z, mad(z->x, z->x, -z->y * z->y)) - z->w * z->w;
	double newy = 2.0 * z->x * z->y - 2.0 * z->w * z->z;
	double newz = 2.0 * z->x * z->z - 2.0 * z->y * z->w;
	double neww = 2.0 * z->x * z->w - 2.0 * z->y * z->z;
	z->x = newx;
	z->y = newy;
	z->z = newz;
	z->w = neww;
}
#endif
