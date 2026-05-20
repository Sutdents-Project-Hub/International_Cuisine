import type { Request as ExpressRequest } from 'express';
import type { Role } from '@prisma/client';

export type AuthUser = {
  id: string;
  email: string;
  role: Role;
};

export type AuthenticatedRequest = ExpressRequest & {
  user: AuthUser;
};
